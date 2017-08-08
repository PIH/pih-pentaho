
delete from user_property where user_id in (select u.user_id from users u, hivmigration_users hu where u.uuid = hu.user_uuid);
delete from user_role where user_id in (select u.user_id from users u, hivmigration_users hu where u.uuid = hu.user_uuid);
delete from users where uuid in (select user_uuid from hivmigration_users);

delete from name_phonetics;
delete from person_name where person_id in (select p.person_id from person p, hivmigration_users hu where p.uuid = hu.person_uuid);
delete from person where uuid in (select person_uuid from hivmigration_users);

delete from hivmigration_users;
