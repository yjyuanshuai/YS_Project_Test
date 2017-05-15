
DROP TABLE Chat_Msg_Table;


/* 聊天记录 */

CREATE TABLE IF NOT EXISTS Chat_Msg_Table
(
msgId text NOT NULL PRIMARY KEY,
msgTime text,
msgType integer,
userName text,
userHeadImage text,
msgData text,
isSelfSend integer
);
