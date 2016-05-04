{% extends template ~ "/layout/main.tpl" %}

{% block body %}
{% if section_name != 'section-mycourses' %}
<div class="container">
    <div class="row">
        <div class="col-md-3 menu-column">
            {% block login_form %}
                    {% if _u.logged  == 0 %}
                            {% include template ~ "/layout/login_form.tpl" %}
                    {% endif %}
            {% endblock %}
            {% if _u.logged  == 1 %}
                {{ user_image_block }}
            {% endif %}
            {{ profile_block }}
        </div>
        <div class="col-md-9">
            {% if announcements_block %}
                <section id="homepage-announcements">
                {{ announcements_block }}
                </section>
            {% endif %}
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            {% if home_page_block %}
            <section id="homepage-home">
                {{ home_page_block }}
            </section>
            {% endif %}

            <!-- block statistics -->
            <div class="statistics">
                <div class="row">
                    <div class="col-md-4">
                        <ul class="items">
                            <li><i class="fa fa-user fa-4x icon-color" aria-hidden="true"></i></li>
                            <li>
                                <h2 class="number">450+</h2>
                                <p class="text">Les utilisateurs enregistrés</p>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <ul class="items">
                            <li><i class="fa fa-book fa-4x icon-color" aria-hidden="true"></i></li>
                            <li>
                                <h2 class="number">30</h2>
                                <p class="text">Les cours ouverts</p>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <ul class="items">
                            <li><i class="fa fa-signal fa-4x icon-color" aria-hidden="true"></i></li>
                            <li>
                                <h2 class="number">300+</h2>
                                <p class="text">Les diplomés</p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- end block statistics -->

            <!-- HOT COURSE -->
            {% include template ~ "/layout/hot_courses.tpl" %}
            <!-- END HOT COURSE -->
            <!-- CMS -->

            {#{% include template ~ "/layout/cms.tpl" %}#}
            <script>
            $(document).ready(function() {
                $.ajax({
                    url: "{{ _p.web }}web/app_dev.php/cms/page/latest/3",
                    success: function (data) {
                        $('#latest_pages').html(data);
                    }
                });
            });
            </script>
            <div id="latest_pages"></div>
            <!-- END CSS -->
        </div>
    </div>
</div>
{% endif %}

{% if section_name != 'section-mycampus' %}
<div class="container">
<div class="row">
    <div class="col-md-3 menu-column">
        {% if _u.logged  == 1 %}
            {{ user_image_block }}
        {% endif %}
        {{ profile_block }}
        {{ course_block }}
        {{ skills_block }}
        {{ certificates_search_block }}
    </div>
    <div class="col-md-9">
        {{ sniff_notification }}

        {% block page_body %}
        {% include template ~ "/layout/page_body.tpl" %}
        {% endblock %}

        {% if welcome_to_course_block %}
            <section id="homepage-course">
            {{ welcome_to_course_block }}
            </section>
        {% endif %}

        {% block content %}
        {% if content is not null %}
            <section id="page-content" class="{{ course_history_page }}">
                {{ content }}
            </section>
        {% endif %}
        {% endblock %}

        {% if course_category_block %}
            <section id="homepage-course-category">
                {{ course_category_block }}
            </section>
        {% endif %}
    </div>
</div>
</div>
{% endif %}
{% endblock %}
