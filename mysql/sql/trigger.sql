CREATE TABLE chat(
	id VARCHAR(32),
	answer VARCHAR(32) NOT NULL
);

CREATE TABLE chatBackup(
	idBackup VARCHAR(32),
	answerBackup VARCHAR(32) NOT NULL
);

INSERT INTO chat VALUE ('pigg', '안녕');
INSERT INTO chat VALUE ('lemon', '반가워');
INSERT INTO chat VALUE ('pigg', '오늘 날씨 어때?');
INSERT INTO chat VALUE ('lemon', '날씨 좋아');

DELIMITER $$
	CREATE TRIGGER autoBackup
	BEFORE  DELETE ON chat
	FOR EACH ROW 
	BEGIN
		DECLARE idTemp VARCHAR(32);
		DECLARE answerTemp VARCHAR(32);
		
		SET idTemp = OLD.id;
		SET answerTemp = OLD.answer;
		
		INSERT INTO chatBackup VALUE (idTemp, answerTemp);
		
	END $$
DELIMITER ;

DELETE FROM chat WHERE id='pigg';

SELECT * FROM chat;

SELECT * FROM chatbackup;