
/* 聊天记录 */

CREATE TABLE IF NOT EXISTS Chat_Msg_Table
(
msgId integer NOT NULL PRIMARY KEY AUTOINCREMENT,
msgTime text,
msgType integer,
userName text,
userHeadImage text,
msgData text
);
