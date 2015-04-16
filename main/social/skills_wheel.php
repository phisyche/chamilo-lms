<?php
/* For licensing terms, see /license.txt */

/**
 *  @package chamilo.admin
 */
$cidReset = true;

require_once '../inc/global.inc.php';

$this_section = SECTION_SOCIAL;

if (api_get_setting('allow_skills_tool') != 'true') {
    api_not_allowed();
}

api_block_anonymous_users();

//Adds the JS needed to use the jqgrid
$htmlHeadXtra[] = api_get_js('d3/d3.v3.5.4.min.js');
$htmlHeadXtra[] = api_get_js('d3/colorbrewer.js');
$htmlHeadXtra[] = api_get_js('d3/jquery.xcolor.js');

$htmlHeadXtra[] = '<script src="'.api_get_path(WEB_LIBRARY_PATH).'javascript/tag/jquery.fcbkcomplete.js" type="text/javascript" language="javascript"></script>';
$htmlHeadXtra[] = '<link  href="'.api_get_path(WEB_LIBRARY_PATH).'javascript/tag/style.css" rel="stylesheet" type="text/css" />';


$tpl = new Template(null, false, false);

$load_user = api_get_user_id();
$userInfo = api_get_user_info();

$skill = new Skill();
$ranking = $skill->get_user_skill_ranking($load_user);
$countSkill = count($skill->get_all());

$mySkills = $skill->get_user_skills($user_id, true);

$skill_condition = '';
if (isset($_GET['skill_id'])) {
    $skill_condition = '&skill_id='.intval($_GET['skill_id']);
    $tpl->assign('skill_id_to_load', $_GET['skill_id']);
}

$url = api_get_path(WEB_AJAX_PATH)."skill.ajax.php?a=get_skills_tree_json&load_user=$load_user";
$tpl->assign('wheel_url', $url);


$url  = api_get_path(WEB_AJAX_PATH).'skill.ajax.php?1=1';
$tpl->assign('url', $url);

$tpl->assign('userInfo', $userInfo);
$tpl->assign('ranking', $ranking);
$tpl->assign('countSkill', $countSkill);
$tpl->assign('mySkills', $mySkills);

$dialogForm = new FormValidator('form', 'post', null, null, ['id' => 'add_item']);
$dialogForm->addLabel(
    get_lang('Name'),
    Display::tag('p', null, ['id' => 'name', 'class' => 'form-control-static'])
);
$dialogForm->addLabel(
    get_lang('ShortCode'),
    Display::tag('p', null, ['id' => 'short_code', 'class' => 'form-control-static'])
);
$dialogForm->addLabel(
    get_lang('Parent'),
    Display::tag('p', null, ['id' => 'parent', 'class' => 'form-control-static'])
);
$dialogForm->addLabel(
    [get_lang('Gradebook'), get_lang('WithCertificate')],
    Display::tag('ul', null, ['id' => 'gradebook', 'class' => 'form-control-static list-unstyled'])
);
$dialogForm->addLabel(
    get_lang('Description'),
    Display::tag('p', null, ['id' => 'description', 'class' => 'form-control-static'])
);

$tpl->assign('dialogForm', $dialogForm->returnForm());

$content = $tpl->fetch('default/skill/skill_wheel_student.tpl');
$tpl->assign('content', $content);
$tpl->display_no_layout_template();