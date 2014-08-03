INSERT INTO vars (name, value, description, type, category) VALUES ('default_textarea_cols', '50', 'Number of columns displayed in the comment and story textareas by default', 'num', 'Stories, Comments');
INSERT INTO vars (name, value, description, type, category) VALUES ('default_textarea_rows', '15', 'Number of rows displayed in the comment and story textareas by default', 'num', 'Stories, Comments');
INSERT INTO vars (name, value, description, type, category) VALUES ('spam_votes_percentage', '0.25', 'Percentage of spam votes required to forced a story into the normal moderation queue', 'num', 'Stories, Comments');
INSERT INTO vars (name, value, description, type, category) VALUES ('spam_votes_threshold', '100', 'Number of spam votes required before the % calculation can take place.', 'num', 'Stories, Comments');
UPDATE blocks SET block = '<!-- vote_console -->
INSERT INTO blocks (bid, block, description, category, theme, language) VALUES ('edit_instructions_abuse', '<P>