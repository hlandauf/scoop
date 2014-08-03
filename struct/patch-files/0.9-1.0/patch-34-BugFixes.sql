ALTER TABLE whos_online DROP PRIMARY KEY, ADD PRIMARY KEY(ip,uid);

UPDATE box SET content = '## New Who\'s Online Box\n## Quite a bit of stuff borrowed from the old one.\n\n# return if anonymous for now\nreturn if $S->{UID} == -1;\n\n# The time stuff can be changed to taste\n\n# The query\n\nmy ($rv,$sth) = $S->db_select({\n   FROM => \'whos_online\',\n   WHAT => \'ip, uid\',\n   WHERE => \'last_visit > DATE_SUB(NOW(), INTERVAL 30 MINUTE)\',\n   ORDER_BY => \'uid\'\n});\n\nmy %uids;\nmy $total;\nmy $anontotal;\n\nwhile (my $s = $sth->fetchrow_hashref()) {\n      if ($s->{\'uid\'} == -1) {\n        $anontotal++;\n        next;\n        }\n   $total++;\n   $uids{ $s->{\'uid\'} }++;\n}\n\n$sth->finish;\n\nmy @sorted = sort keys %uids;\n\nmy $out;\nmy $hidden;\nforeach (@sorted) {\n   if ($S->user_data($_)->{prefs}->{online_cloak}) {\n      $hidden++;\n      next;\n   }\n   my $nick = $S->user_data($_)->{nickname};\n   $out .= qq~%%dot%% <A HREF="%%rootdir%%/user/uid:$_">$nick</A>~;\n   $out .= " ($uids{$_})" if $uids{$_} > 1;\n   $out .= "<BR>\\n";\n}\nif($anontotal){\n   my $anon_user_nick = $S->{UI}->{VARS}->{anon_user_nick};\n   $out .= "%%dot%% $anon_user_nick ($anontotal)<BR>";\n   }\nif ($hidden) {\n   $out .= qq~%%dot%% Cloaked Users ($hidden)<p>~;\n} else {\n   $out .= \'<p>\';\n}\n$total = $total + $anontotal;\n$out .= qq~<small>Note: You may cloak yourself from appearing here in your <A HREF="%%rootdir%%/interface/prefs">Display Preferences</A></small>.~;\nreturn {content => $out, title => "Who\'s Online? ($total)"};\n' WHERE boxid = 'whos_online';

INSERT INTO blocks VALUES ('new_user_email_subject', "Welcome to %%sitename%%", "1", "<P>This block defines the subject line for the email sent to new accounts. It should be short and not have any HTML. Because this is an email it is not processed the way web pages are and the only key recognized is the special key sitename, which is replaced with the contents of the site control <B>sitename</B></P>", "Accounts,Emails", 'default', 'en');
INSERT INTO blocks VALUES ('new_user_email', "Someone requested a new user account on %%url%%/\nand gave this email address as their contact.\n\nIf this was you, please use the following username and password to log\nin:\n\n\tUsername: %%nick%%\n\tPassword: %%pass%%\n%%showprefs%%\nIf it wasn\'t you, please ignore this email. Our system will delete the\naccount automatically if it remains unused. You will not get any\nfurther e-mail from us. The account is free.\n\nWe hope you enjoy %%sitename%%!\n\n-- %%from%%", "1", "<P>This block contains the body of the email send when new accounts are created. It should not have any HTML. Because this is an email it is not processed the way web pages are and the only keys recognized are:</P>\n<DL>\n <DT>url</DT>\n  <DD>The full URL to the front page of the site.</DD>\n <DT>nick</DT>\n  <DD>The nickname that was just created</DD>\n <DT>pass</DT>\n  <DD>The generated password sent to the new user</DD>\n <DT>showprefs</DT>\n  <DD>If the variable <B>show_prefs_on_first_login</B> is set to 1, the contents of the block <B>new_user_email_showprefs</B>, otherwise blank.</DD>\n <DT>from</DT>\n  <DD>The email address the newuser email was sent from. This is the variable <B>new_user_email_from</B> if set, and <B>local_email</B> otherwise.</DD>\n</DL>", "Accounts,Emails", 'default', 'en');
INSERT INTO blocks VALUES ('new_user_email_showprefs', "After first logging in, you will be automatically redirected to your\nuser preferences page, where you can change your password if you want\nto.", "1", "<P>This block contains text that will be included in the block <B>new_user_email</B> if the site control <B>show_prefs_on_first_login</B> is set to 1. It should not have any HTML. Since emails are not sent through the usual page processing, this block cannot use any of the normal keys available to most blocks.</P>", "Accounts,Emails", 'default', 'en');
INSERT INTO vars VALUES ('new_user_email_from', '', "<P>This variable is used as the from email address used by Scoop when sending user creation emails. The possible values are any valid email address, or blank. If blank, the email address set in the variable <B>local_email</B> will be used instead.<BR>\nThis email address should probably be one you check regularly.  Since members are sent email from this address, they are likely to think that they can send to it as well, if they have any questions.  If this email address is not valid, nobody will be able to create accounts.</p>", "text", "General");

