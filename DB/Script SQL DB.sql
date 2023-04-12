-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema palestraBDprj
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `palestraBDprj` ;

-- -----------------------------------------------------
-- Schema palestraBDprj
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `palestraBDprj` DEFAULT CHARACTER SET utf8 ;
USE `palestraBDprj` ;

-- -----------------------------------------------------
-- Table `palestraBDprj`.`personaltrainer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palestraBDprj`.`personaltrainer` ;

CREATE TABLE IF NOT EXISTS `palestraBDprj`.`personaltrainer` (
  `nome` VARCHAR(20) NOT NULL,
  `cognome` VARCHAR(20) NOT NULL,
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `personaltrainer_nome_cognome` ON `palestraBDprj`.`personaltrainer` (`cognome` ASC, `nome` ASC) INVISIBLE;


-- -----------------------------------------------------
-- Table `palestraBDprj`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palestraBDprj`.`cliente` ;

CREATE TABLE IF NOT EXISTS `palestraBDprj`.`cliente` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(20) NOT NULL,
  `cognome` VARCHAR(20) NOT NULL,
  `personaltrainer_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cliente_personaltrainer1`
    FOREIGN KEY (`personaltrainer_id`)
    REFERENCES `palestraBDprj`.`personaltrainer` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `cliente_nome_cognome` ON `palestraBDprj`.`cliente` (`nome` ASC, `cognome` ASC) VISIBLE;

CREATE INDEX `fk_cliente_personaltrainer1_idx` ON `palestraBDprj`.`cliente` (`personaltrainer_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `palestraBDprj`.`storico_macchinario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palestraBDprj`.`storico_macchinario` ;

CREATE TABLE IF NOT EXISTS `palestraBDprj`.`storico_macchinario` (
  `nomemacchinario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nomemacchinario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palestraBDprj`.`storico_esercizio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palestraBDprj`.`storico_esercizio` ;

CREATE TABLE IF NOT EXISTS `palestraBDprj`.`storico_esercizio` (
  `nomeesercizio` VARCHAR(45) NOT NULL,
  `nomemacchinario` VARCHAR(45) NULL,
  PRIMARY KEY (`nomeesercizio`),
  CONSTRAINT `fk_esercizio_macchinario`
    FOREIGN KEY (`nomemacchinario`)
    REFERENCES `palestraBDprj`.`storico_macchinario` (`nomemacchinario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_esercizio_macchinario1_idx` ON `palestraBDprj`.`storico_esercizio` (`nomemacchinario` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `palestraBDprj`.`schedadiallenamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palestraBDprj`.`schedadiallenamento` ;

CREATE TABLE IF NOT EXISTS `palestraBDprj`.`schedadiallenamento` (
  `dataassegnazione` DATE NOT NULL,
  `datafine` DATE NULL,
  `personaltrainer_id` INT UNSIGNED NULL,
  `cliente_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`dataassegnazione`, `cliente_id`),
  CONSTRAINT `fk_schedadiallenamento_personaltrainer1`
    FOREIGN KEY (`personaltrainer_id`)
    REFERENCES `palestraBDprj`.`personaltrainer` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedadiallenamento_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `palestraBDprj`.`cliente` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_schedadiallenamento_personaltrainer1_idx` ON `palestraBDprj`.`schedadiallenamento` (`personaltrainer_id` ASC) VISIBLE;

CREATE INDEX `fk_schedadiallenamento_cliente1_idx` ON `palestraBDprj`.`schedadiallenamento` (`cliente_id` ASC) VISIBLE;

CREATE INDEX `byfinescheda` ON `palestraBDprj`.`schedadiallenamento` (`datafine` DESC) VISIBLE;


-- -----------------------------------------------------
-- Table `palestraBDprj`.`sessione`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palestraBDprj`.`sessione` ;

CREATE TABLE IF NOT EXISTS `palestraBDprj`.`sessione` (
  `percentualecompletamento` FLOAT UNSIGNED NOT NULL DEFAULT 0,
  `durata` TIME NOT NULL,
  `datasessione` DATE NOT NULL,
  `dataassegnazione` DATE NOT NULL,
  `cliente_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`cliente_id`, `datasessione`),
  CONSTRAINT `fk_sessione_schedadiallenamento1`
    FOREIGN KEY (`dataassegnazione` , `cliente_id`)
    REFERENCES `palestraBDprj`.`schedadiallenamento` (`dataassegnazione` , `cliente_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_sessione_schedadiallenamento1_idx` ON `palestraBDprj`.`sessione` (`cliente_id` ASC, `dataassegnazione` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `palestraBDprj`.`composizione`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palestraBDprj`.`composizione` ;

CREATE TABLE IF NOT EXISTS `palestraBDprj`.`composizione` (
  `serie` INT UNSIGNED NOT NULL,
  `ripetizioni` INT UNSIGNED NOT NULL,
  `ordinenellascheda` INT UNSIGNED NOT NULL,
  `nomeesercizio` VARCHAR(45) NOT NULL,
  `dataassegnazione` DATE NOT NULL,
  `cliente_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`nomeesercizio`, `dataassegnazione`, `cliente_id`),
  CONSTRAINT `fk_composizione_esercizio1`
    FOREIGN KEY (`nomeesercizio`)
    REFERENCES `palestraBDprj`.`storico_esercizio` (`nomeesercizio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_composizione_schedadiallenamento1`
    FOREIGN KEY (`dataassegnazione` , `cliente_id`)
    REFERENCES `palestraBDprj`.`schedadiallenamento` (`dataassegnazione` , `cliente_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palestraBDprj`.`utenti`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palestraBDprj`.`utenti` ;

CREATE TABLE IF NOT EXISTS `palestraBDprj`.`utenti` (
  `nome` VARCHAR(20) NOT NULL,
  `cognome` VARCHAR(20) NOT NULL,
  `password` CHAR(32) NOT NULL,
  `ruolo` ENUM('amministratore', 'cliente', 'personalTrainer') NOT NULL,
  PRIMARY KEY (`nome`, `cognome`));


-- -----------------------------------------------------
-- Table `palestraBDprj`.`macchinario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palestraBDprj`.`macchinario` ;

CREATE TABLE IF NOT EXISTS `palestraBDprj`.`macchinario` (
  `nomemacchinario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nomemacchinario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `palestraBDprj`.`esercizio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `palestraBDprj`.`esercizio` ;

CREATE TABLE IF NOT EXISTS `palestraBDprj`.`esercizio` (
  `nomeesercizio` VARCHAR(45) NOT NULL,
  `macchinario_nomemacchinario` VARCHAR(45) NULL,
  PRIMARY KEY (`nomeesercizio`),
  CONSTRAINT `fk_esercizio_macchinario1`
    FOREIGN KEY (`macchinario_nomemacchinario`)
    REFERENCES `palestraBDprj`.`macchinario` (`nomemacchinario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_esercizio_macchinario1_idx` ON `palestraBDprj`.`esercizio` (`macchinario_nomemacchinario` ASC) VISIBLE;

USE `palestraBDprj` ;

-- -----------------------------------------------------
-- procedure inserisciSessione
-- -----------------------------------------------------

USE `palestraBDprj`;
DROP procedure IF EXISTS `palestraBDprj`.`inserisciSessione`;

DELIMITER $$
USE `palestraBDprj`$$
CREATE PROCEDURE `inserisciSessione` (in clienteID int, in dataAssegnazione date, in percentualeCompletamento float, in durata time, in dataEsecuzione datetime)
BEGIN
	declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;
    
    set transaction isolation level serializable;
    set transaction read write;
	
    start transaction;
		/* Trigger per controllare che il cliente possa inserire una sessione di allenamento per la scheda di allenamento specificata */
		
        -- Inserisco la sessione di allenamento nella tabella
		insert into sessione value (percentualeCompletamento, durata, dataEsecuzione, dataAssegnazione, clienteID);
    commit;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure vediSchedaDiAllenamento
-- -----------------------------------------------------

USE `palestraBDprj`;
DROP procedure IF EXISTS `palestraBDprj`.`vediSchedaDiAllenamento`;

DELIMITER $$
USE `palestraBDprj`$$
CREATE PROCEDURE `vediSchedaDiAllenamento` (in clienteID int)
BEGIN
	select dataassegnazione, ordinenellascheda as ordine, nomeesercizio, serie, ripetizioni
    from composizione
    where cliente_id = clienteID and dataassegnazione = (select dataassegnazione from schedadiallenamento where cliente_id = clienteID and datafine is null)
	order by ordinenellascheda;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure vediTutteLeSchedeDiAllenamento
-- -----------------------------------------------------

USE `palestraBDprj`;
DROP procedure IF EXISTS `palestraBDprj`.`vediTutteLeSchedeDiAllenamento`;

DELIMITER $$
USE `palestraBDprj`$$
CREATE PROCEDURE `vediTutteLeSchedeDiAllenamento` (in clienteID int)
BEGIN
	declare done int default false;
	declare var_scheda date;
    
	declare cur cursor for
		select dataassegnazione from schedadiallenamento where cliente_id = clienteID;
    
    declare continue handler for not found set done = true;
    
	if (select id from cliente where id = clienteID) is null then
		signal sqlstate '45001' set message_text = 'ID cliente non valido';
	end if;
    
    open cur;
	read_loop: loop
		fetch cur into var_scheda;
        
        if done then
			leave read_loop;
		end if;
		
        select dataassegnazione, ordinenellascheda, nomeesercizio, serie, ripetizioni
		from composizione
		where cliente_id = clienteID and dataassegnazione = var_scheda
		order by ordinenellascheda;
	end loop;
    close cur;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure creaNuovaSchedaDiAllenamento
-- -----------------------------------------------------

USE `palestraBDprj`;
DROP procedure IF EXISTS `palestraBDprj`.`creaNuovaSchedaDiAllenamento`;

DELIMITER $$
USE `palestraBDprj`$$
CREATE PROCEDURE `creaNuovaSchedaDiAllenamento` (in personalTrainerID int, in clienteID int)
BEGIN
	declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;
    
    set transaction isolation level repeatable read;
    set transaction read write;

	start transaction;
		-- Aggiorno l'ultima scheda di allenamento del cliente
		update schedadiallenamento set datafine = curdate() where cliente_id = clienteID and datafine is null;
        
        /* Trigger before insert per controllare se il personal trainer effettivamente possa assegnargli la scheda di allenamento */
        
        -- Inserisco il riferimento alla nuova scheda di allenamento
        insert into schedadiallenamento (dataassegnazione, personaltrainer_id, cliente_id) value (curdate(), personalTrainerID, clienteID);
	commit;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure vediReport
-- -----------------------------------------------------

USE `palestraBDprj`;
DROP procedure IF EXISTS `palestraBDprj`.`vediReport`;

DELIMITER $$
USE `palestraBDprj`$$
CREATE PROCEDURE `vediReport` (in personalTrainerID int, in datainizio date, in datafine date)
BEGIN
	declare done int default false;
	declare var_clienteID int;
    
	declare cur cursor for
		select id from cliente where personaltrainer_id = personalTrainerID;
	
	declare continue handler for not found set done = true;
    
    -- Nel caso la data inserita per il report fosse avanti rispetto a oggi
    if datafine > curdate() then
		set datafine = curdate();
    end if;
    
    if datafine = curdate() then
		set transaction isolation level repeatable read;
	end if;
    if datafine < curdate() then
		set transaction isolation level read uncommitted;
	end if;
	
    set transaction read only;
	
    start transaction;
		open cur;
		read_loop: loop
			fetch cur into var_clienteID;
        
			if done then
				leave read_loop;
			end if;
    
			select nome, cognome, cliente_id, count(*) as numeroallenamenti
			from cliente join sessione on (cliente.ID = sessione.cliente_id and cliente.ID = var_clienteID)
			where personaltrainer_id = personalTrainerID and (datainizio <= datasessione and datasessione <= datafine) and cliente_id = var_clienteID
            group by cliente_id;

			select cliente_id, nome, cognome, dataassegnazione as dataassegnazionescheda, datasessione, durata, percentualecompletamento
			from cliente 
			join sessione on cliente.ID = sessione.cliente_id
			where personaltrainer_id = personalTrainerID and (datainizio <= datasessione and datasessione <= datafine) and cliente_id = var_clienteID;
		end loop;
		close cur;
    
		commit;
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure inserisciEsercizioInScheda
-- -----------------------------------------------------

USE `palestraBDprj`;
DROP procedure IF EXISTS `palestraBDprj`.`inserisciEsercizioInScheda`;

DELIMITER $$
USE `palestraBDprj`$$
CREATE PROCEDURE `inserisciEsercizioInScheda` (in personalTrainerID int, in clienteID int, in dataassegnazione date, in nomeEsercizio varchar(45), in serie int, in ripetizioni int, in ordineNellaScheda int)
BEGIN
	declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;
    
    set transaction isolation level read committed;
    set transaction read write;

	start transaction;
		-- Controllo che effivamente il personal trainer abbia assegnato il cliente
		if personalTrainerID not in (select personaltrainer_id from cliente where id = clienteID) then
			signal sqlstate '45001' set message_text = 'Non si ha affiliato questo cliente';
        end if;
        
        /* Trigger per controllare se la scheda di allenamento sia valida */
		
        -- Inserisco l'esercizio da assegnare alla scheda
		insert into composizione value (serie, ripetizioni, ordineNellaScheda, nomeEsercizio, dataassegnazione, clienteID);
    commit;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure login
-- -----------------------------------------------------

USE `palestraBDprj`;
DROP procedure IF EXISTS `palestraBDprj`.`login`;

DELIMITER $$
USE `palestraBDprj`$$
CREATE PROCEDURE `login` (in var_nome varchar(20), in var_cognome varchar(20), in var_password varchar(32), out var_ruolo int, out var_id int)
BEGIN
	declare var_user_role ENUM('amministratore', 'cliente', 'personalTrainer');
    
	select ruolo from utenti
	where nome = var_nome and cognome = var_cognome and password = md5(var_password)
	into var_user_role;
    
	-- Faccio combaciare con l'enum del client
	if var_user_role = 'amministratore' then
		set var_ruolo = 1;
		set var_id = 0;
	elseif var_user_role = 'cliente' then
		set var_ruolo = 2;
        set var_id = (select id from cliente where nome = var_nome and cognome = var_cognome);
	elseif var_user_role = 'personalTrainer' then
		set var_ruolo = 3;
        set var_id = (select id from personaltrainer where nome = var_nome and cognome = var_cognome);
	else
		set var_ruolo = 4;
        set var_id = -1;
	end if;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure vediListaEserciziDisponibili
-- -----------------------------------------------------

USE `palestraBDprj`;
DROP procedure IF EXISTS `palestraBDprj`.`vediListaEserciziDisponibili`;

DELIMITER $$
USE `palestraBDprj`$$
CREATE PROCEDURE `vediListaEserciziDisponibili` ()
BEGIN
	select nomeesercizio from esercizio;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure vediClientiAffiliati
-- -----------------------------------------------------

USE `palestraBDprj`;
DROP procedure IF EXISTS `palestraBDprj`.`vediClientiAffiliati`;

DELIMITER $$
USE `palestraBDprj`$$
CREATE PROCEDURE `vediClientiAffiliati` (in var_personalTrainerID int)
BEGIN
	select id, nome, cognome from cliente where personaltrainer_id = var_personalTrainerID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure inserisciEsercizio
-- -----------------------------------------------------

USE `palestraBDprj`;
DROP procedure IF EXISTS `palestraBDprj`.`inserisciEsercizio`;

DELIMITER $$
USE `palestraBDprj`$$
CREATE PROCEDURE `inserisciEsercizio` (in nomeEsercizio varchar(45), in nomeMacchinario varchar(45))
BEGIN
    declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;
    
	set transaction isolation level serializable;
    set transaction read write;
	
    start transaction;
		/* Trigger per inserire l'esercizio anche nella tabella storico_esercizio */
		
        -- Inserisco l'esercizio nella tabella degli esercizi assegnabili
		insert into esercizio value (nomeEsercizio, nomeMacchinario);
    commit;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure inserisciMacchinario
-- -----------------------------------------------------

USE `palestraBDprj`;
DROP procedure IF EXISTS `palestraBDprj`.`inserisciMacchinario`;

DELIMITER $$
USE `palestraBDprj`$$
CREATE PROCEDURE `inserisciMacchinario` (in nomeMacchinario varchar(45))
BEGIN
	declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;
    
    set transaction read write;
	
    start transaction;
		/* Trigger per inserire il macchinario anche nella tabella storico_macchinario */
		
        -- Inserisco il macchinario nella tabella dei macchinari utilizzabili
		insert into macchinario value (nomeMacchinario);
    commit;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure rimuoviEsercizio
-- -----------------------------------------------------

USE `palestraBDprj`;
DROP procedure IF EXISTS `palestraBDprj`.`rimuoviEsercizio`;

DELIMITER $$
USE `palestraBDprj`$$
CREATE PROCEDURE `rimuoviEsercizio` (in var_nomeEsercizio varchar(45))
BEGIN
	declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;
    
	set transaction isolation level serializable;
    set transaction read write;
	
    start transaction;
		delete from esercizio where (nomeesercizio = var_nomeEsercizio);
    commit;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure rimuoviMacchinario
-- -----------------------------------------------------

USE `palestraBDprj`;
DROP procedure IF EXISTS `palestraBDprj`.`rimuoviMacchinario`;

DELIMITER $$
USE `palestraBDprj`$$
CREATE PROCEDURE `rimuoviMacchinario` (in var_nomeMacchinario varchar(45))
BEGIN
	declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;
    
	set transaction isolation level serializable;
    set transaction read write;
	
    start transaction;
		delete from macchinario where nomemacchinario = var_nomeMacchinario;
    commit;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure vediListaMacchinariDisponibili
-- -----------------------------------------------------

USE `palestraBDprj`;
DROP procedure IF EXISTS `palestraBDprj`.`vediListaMacchinariDisponibili`;

DELIMITER $$
USE `palestraBDprj`$$
CREATE PROCEDURE `vediListaMacchinariDisponibili` ()
BEGIN
	select * from macchinario;
END$$

DELIMITER ;
USE `palestraBDprj`;

DELIMITER ;
SET SQL_MODE = '';
DROP USER IF EXISTS amministratore;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'amministratore' IDENTIFIED BY 'amministratore';

GRANT ALL ON TABLE `palestraBDprj`.`personaltrainer` TO 'amministratore';
GRANT ALL ON TABLE `palestraBDprj`.`cliente` TO 'amministratore';
GRANT ALL ON TABLE `palestraBDprj`.`composizione` TO 'amministratore';
GRANT ALL ON TABLE `palestraBDprj`.`storico_esercizio` TO 'amministratore';
GRANT ALL ON TABLE `palestraBDprj`.`storico_macchinario` TO 'amministratore';
GRANT ALL ON TABLE `palestraBDprj`.`schedadiallenamento` TO 'amministratore';
GRANT ALL ON TABLE `palestraBDprj`.`sessione` TO 'amministratore';
GRANT ALL ON TABLE `palestraBDprj`.`utenti` TO 'amministratore';
GRANT ALL ON procedure `palestraBDprj`.`login` TO 'amministratore';
GRANT ALL ON procedure `palestraBDprj`.`inserisciEsercizio` TO 'amministratore';
GRANT ALL ON procedure `palestraBDprj`.`inserisciMacchinario` TO 'amministratore';
GRANT ALL ON procedure `palestraBDprj`.`rimuoviEsercizio` TO 'amministratore';
GRANT ALL ON procedure `palestraBDprj`.`rimuoviMacchinario` TO 'amministratore';
GRANT ALL ON procedure `palestraBDprj`.`vediListaMacchinariDisponibili` TO 'amministratore';
GRANT ALL ON procedure `palestraBDprj`.`vediListaEserciziDisponibili` TO 'amministratore';
GRANT ALL ON procedure `palestraBDprj`.`creaNuovaSchedaDiAllenamento` TO 'amministratore';
GRANT ALL ON procedure `palestraBDprj`.`inserisciEsercizioInScheda` TO 'amministratore';
GRANT ALL ON procedure `palestraBDprj`.`inserisciSessione` TO 'amministratore';
GRANT ALL ON procedure `palestraBDprj`.`vediClientiAffiliati` TO 'amministratore';
GRANT ALL ON procedure `palestraBDprj`.`vediReport` TO 'amministratore';
GRANT ALL ON procedure `palestraBDprj`.`vediSchedaDiAllenamento` TO 'amministratore';
GRANT ALL ON procedure `palestraBDprj`.`vediTutteLeSchedeDiAllenamento` TO 'amministratore';
SET SQL_MODE = '';
DROP USER IF EXISTS cliente;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'cliente' IDENTIFIED BY 'cliente';

GRANT EXECUTE ON procedure `palestraBDprj`.`vediSchedaDiAllenamento` TO 'cliente';
GRANT EXECUTE ON procedure `palestraBDprj`.`inserisciSessione` TO 'cliente';
GRANT EXECUTE ON procedure `palestraBDprj`.`vediTutteLeSchedeDiAllenamento` TO 'cliente';
GRANT EXECUTE ON procedure `palestraBDprj`.`login` TO 'cliente';
SET SQL_MODE = '';
DROP USER IF EXISTS personalTrainer;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'personalTrainer' IDENTIFIED BY 'personaltrainer';

GRANT EXECUTE ON procedure `palestraBDprj`.`creaNuovaSchedaDiAllenamento` TO 'personalTrainer';
GRANT EXECUTE ON procedure `palestraBDprj`.`inserisciEsercizioInScheda` TO 'personalTrainer';
GRANT EXECUTE ON procedure `palestraBDprj`.`vediReport` TO 'personalTrainer';
GRANT EXECUTE ON procedure `palestraBDprj`.`login` TO 'personalTrainer';
GRANT EXECUTE ON procedure `palestraBDprj`.`vediListaEserciziDisponibili` TO 'personalTrainer';
GRANT EXECUTE ON procedure `palestraBDprj`.`vediClientiAffiliati` TO 'personalTrainer';
SET SQL_MODE = '';
DROP USER IF EXISTS login;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'login' IDENTIFIED BY 'login';

GRANT EXECUTE ON procedure `palestraBDprj`.`login` TO 'login';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `palestraBDprj`.`personaltrainer`
-- -----------------------------------------------------
START TRANSACTION;
USE `palestraBDprj`;
INSERT INTO `palestraBDprj`.`personaltrainer` (`nome`, `cognome`, `id`) VALUES ('Ansley', 'Torri', 1);
INSERT INTO `palestraBDprj`.`personaltrainer` (`nome`, `cognome`, `id`) VALUES ('Fonz', 'Aucourte', 2);
INSERT INTO `palestraBDprj`.`personaltrainer` (`nome`, `cognome`, `id`) VALUES ('Nalani', 'Pentercost', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `palestraBDprj`.`cliente`
-- -----------------------------------------------------
START TRANSACTION;
USE `palestraBDprj`;
INSERT INTO `palestraBDprj`.`cliente` (`id`, `nome`, `cognome`, `personaltrainer_id`) VALUES (1, 'Roosevelt', 'Emberson', 1);
INSERT INTO `palestraBDprj`.`cliente` (`id`, `nome`, `cognome`, `personaltrainer_id`) VALUES (2, 'Bab', 'Sange', 1);
INSERT INTO `palestraBDprj`.`cliente` (`id`, `nome`, `cognome`, `personaltrainer_id`) VALUES (3, 'Idelle', 'Hindmore', 1);
INSERT INTO `palestraBDprj`.`cliente` (`id`, `nome`, `cognome`, `personaltrainer_id`) VALUES (4, 'Vanna', 'MacAnulty', 2);
INSERT INTO `palestraBDprj`.`cliente` (`id`, `nome`, `cognome`, `personaltrainer_id`) VALUES (5, 'Blaire', 'Haynes', 2);
INSERT INTO `palestraBDprj`.`cliente` (`id`, `nome`, `cognome`, `personaltrainer_id`) VALUES (6, 'Jonathan', 'Firpo', 2);
INSERT INTO `palestraBDprj`.`cliente` (`id`, `nome`, `cognome`, `personaltrainer_id`) VALUES (7, 'Dell', 'Noden', 3);
INSERT INTO `palestraBDprj`.`cliente` (`id`, `nome`, `cognome`, `personaltrainer_id`) VALUES (8, 'Sampson', 'Ranscombe', 3);
INSERT INTO `palestraBDprj`.`cliente` (`id`, `nome`, `cognome`, `personaltrainer_id`) VALUES (9, 'Roger', 'Conaghy', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `palestraBDprj`.`storico_macchinario`
-- -----------------------------------------------------
START TRANSACTION;
USE `palestraBDprj`;
INSERT INTO `palestraBDprj`.`storico_macchinario` (`nomemacchinario`) VALUES ('LAT MACHINE');
INSERT INTO `palestraBDprj`.`storico_macchinario` (`nomemacchinario`) VALUES ('LEG PRESS');
INSERT INTO `palestraBDprj`.`storico_macchinario` (`nomemacchinario`) VALUES ('LEG EXTENSION');
INSERT INTO `palestraBDprj`.`storico_macchinario` (`nomemacchinario`) VALUES ('MANUBRI');
INSERT INTO `palestraBDprj`.`storico_macchinario` (`nomemacchinario`) VALUES ('BILANCIERE');
INSERT INTO `palestraBDprj`.`storico_macchinario` (`nomemacchinario`) VALUES ('CYCLETTE');
INSERT INTO `palestraBDprj`.`storico_macchinario` (`nomemacchinario`) VALUES ('SBARRA');
INSERT INTO `palestraBDprj`.`storico_macchinario` (`nomemacchinario`) VALUES ('TAPIS ROULANT');

COMMIT;


-- -----------------------------------------------------
-- Data for table `palestraBDprj`.`storico_esercizio`
-- -----------------------------------------------------
START TRANSACTION;
USE `palestraBDprj`;
INSERT INTO `palestraBDprj`.`storico_esercizio` (`nomeesercizio`, `nomemacchinario`) VALUES ('LAT MACHINE AVANTI', 'LAT MACHINE');
INSERT INTO `palestraBDprj`.`storico_esercizio` (`nomeesercizio`, `nomemacchinario`) VALUES ('LAT MACHINE DIETRO', 'LAT MACHINE');
INSERT INTO `palestraBDprj`.`storico_esercizio` (`nomeesercizio`, `nomemacchinario`) VALUES ('IPERTENSIONI', NULL);
INSERT INTO `palestraBDprj`.`storico_esercizio` (`nomeesercizio`, `nomemacchinario`) VALUES ('PLANK', NULL);
INSERT INTO `palestraBDprj`.`storico_esercizio` (`nomeesercizio`, `nomemacchinario`) VALUES ('JUMPING JACKS', NULL);
INSERT INTO `palestraBDprj`.`storico_esercizio` (`nomeesercizio`, `nomemacchinario`) VALUES ('SIT UP', NULL);
INSERT INTO `palestraBDprj`.`storico_esercizio` (`nomeesercizio`, `nomemacchinario`) VALUES ('CRUNCHES', NULL);
INSERT INTO `palestraBDprj`.`storico_esercizio` (`nomeesercizio`, `nomemacchinario`) VALUES ('PUSH UP', NULL);
INSERT INTO `palestraBDprj`.`storico_esercizio` (`nomeesercizio`, `nomemacchinario`) VALUES ('CORSA', 'TAPIS ROULANT');

COMMIT;


-- -----------------------------------------------------
-- Data for table `palestraBDprj`.`schedadiallenamento`
-- -----------------------------------------------------
START TRANSACTION;
USE `palestraBDprj`;
INSERT INTO `palestraBDprj`.`schedadiallenamento` (`dataassegnazione`, `datafine`, `personaltrainer_id`, `cliente_id`) VALUES ('2022-09-01', '2022-10-01', 1, 1);
INSERT INTO `palestraBDprj`.`schedadiallenamento` (`dataassegnazione`, `datafine`, `personaltrainer_id`, `cliente_id`) VALUES ('2022-11-01', NULL, 1, 1);
INSERT INTO `palestraBDprj`.`schedadiallenamento` (`dataassegnazione`, `datafine`, `personaltrainer_id`, `cliente_id`) VALUES ('2022-09-03', '2022-10-03', 1, 3);
INSERT INTO `palestraBDprj`.`schedadiallenamento` (`dataassegnazione`, `datafine`, `personaltrainer_id`, `cliente_id`) VALUES ('2022-09-02', '2022-10-02', 1, 2);
INSERT INTO `palestraBDprj`.`schedadiallenamento` (`dataassegnazione`, `datafine`, `personaltrainer_id`, `cliente_id`) VALUES ('2022-11-02', NULL, 1, 2);
INSERT INTO `palestraBDprj`.`schedadiallenamento` (`dataassegnazione`, `datafine`, `personaltrainer_id`, `cliente_id`) VALUES ('2022-10-03', '2022-11-03', 1, 3);
INSERT INTO `palestraBDprj`.`schedadiallenamento` (`dataassegnazione`, `datafine`, `personaltrainer_id`, `cliente_id`) VALUES ('2022-10-02', '2022-11-02', 1, 2);
INSERT INTO `palestraBDprj`.`schedadiallenamento` (`dataassegnazione`, `datafine`, `personaltrainer_id`, `cliente_id`) VALUES ('2022-11-03', NULL, 1, 3);
INSERT INTO `palestraBDprj`.`schedadiallenamento` (`dataassegnazione`, `datafine`, `personaltrainer_id`, `cliente_id`) VALUES ('2022-10-01', '2022-11-01', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `palestraBDprj`.`sessione`
-- -----------------------------------------------------
START TRANSACTION;
USE `palestraBDprj`;
INSERT INTO `palestraBDprj`.`sessione` (`percentualecompletamento`, `durata`, `datasessione`, `dataassegnazione`, `cliente_id`) VALUES (100, '01:15:00', '2022-11-11', '2022-11-01', 1);
INSERT INTO `palestraBDprj`.`sessione` (`percentualecompletamento`, `durata`, `datasessione`, `dataassegnazione`, `cliente_id`) VALUES (100, '00:57:24', '2022-11-21', '2022-11-01', 1);
INSERT INTO `palestraBDprj`.`sessione` (`percentualecompletamento`, `durata`, `datasessione`, `dataassegnazione`, `cliente_id`) VALUES (95, '01:20:00', '2022-12-01', '2022-11-01', 1);
INSERT INTO `palestraBDprj`.`sessione` (`percentualecompletamento`, `durata`, `datasessione`, `dataassegnazione`, `cliente_id`) VALUES (57, '00:46:23', '2022-11-12', '2022-11-02', 2);
INSERT INTO `palestraBDprj`.`sessione` (`percentualecompletamento`, `durata`, `datasessione`, `dataassegnazione`, `cliente_id`) VALUES (76, '00:59:34', '2022-11-22', '2022-11-02', 2);
INSERT INTO `palestraBDprj`.`sessione` (`percentualecompletamento`, `durata`, `datasessione`, `dataassegnazione`, `cliente_id`) VALUES (43, '00:23:51', '2022-12-02', '2022-11-02', 2);
INSERT INTO `palestraBDprj`.`sessione` (`percentualecompletamento`, `durata`, `datasessione`, `dataassegnazione`, `cliente_id`) VALUES (89, '00:52:01', '2022-11-13', '2022-11-03', 3);
INSERT INTO `palestraBDprj`.`sessione` (`percentualecompletamento`, `durata`, `datasessione`, `dataassegnazione`, `cliente_id`) VALUES (96, '01:03:27', '2022-11-23', '2022-11-03', 3);
INSERT INTO `palestraBDprj`.`sessione` (`percentualecompletamento`, `durata`, `datasessione`, `dataassegnazione`, `cliente_id`) VALUES (100, '01:07:59', '2022-12-03', '2022-11-03', 3);
INSERT INTO `palestraBDprj`.`sessione` (`percentualecompletamento`, `durata`, `datasessione`, `dataassegnazione`, `cliente_id`) VALUES (100, '01:23:00', '2022-11-01', '2022-11-01', 1);
INSERT INTO `palestraBDprj`.`sessione` (`percentualecompletamento`, `durata`, `datasessione`, `dataassegnazione`, `cliente_id`) VALUES (99, '01:54:34', '2022-10-31', '2022-10-01', 1);
INSERT INTO `palestraBDprj`.`sessione` (`percentualecompletamento`, `durata`, `datasessione`, `dataassegnazione`, `cliente_id`) VALUES (46, '00:45:34', '2022-09-11', '2022-09-01', 1);
INSERT INTO `palestraBDprj`.`sessione` (`percentualecompletamento`, `durata`, `datasessione`, `dataassegnazione`, `cliente_id`) VALUES (50, '00:55:00', '2022-09-21', '2022-09-01', 1);
INSERT INTO `palestraBDprj`.`sessione` (`percentualecompletamento`, `durata`, `datasessione`, `dataassegnazione`, `cliente_id`) VALUES (56, '01:00:00', '2022-10-01', '2022-10-01', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `palestraBDprj`.`composizione`
-- -----------------------------------------------------
START TRANSACTION;
USE `palestraBDprj`;
INSERT INTO `palestraBDprj`.`composizione` (`serie`, `ripetizioni`, `ordinenellascheda`, `nomeesercizio`, `dataassegnazione`, `cliente_id`) VALUES (3, 20, 1, 'JUMPING JACKS', '2022-11-02', 2);
INSERT INTO `palestraBDprj`.`composizione` (`serie`, `ripetizioni`, `ordinenellascheda`, `nomeesercizio`, `dataassegnazione`, `cliente_id`) VALUES (2, 60, 2, 'PLANK', '2022-11-02', 2);
INSERT INTO `palestraBDprj`.`composizione` (`serie`, `ripetizioni`, `ordinenellascheda`, `nomeesercizio`, `dataassegnazione`, `cliente_id`) VALUES (5, 20, 3, 'PUSH UP', '2022-11-02', 2);
INSERT INTO `palestraBDprj`.`composizione` (`serie`, `ripetizioni`, `ordinenellascheda`, `nomeesercizio`, `dataassegnazione`, `cliente_id`) VALUES (3, 15, 4, 'SIT UP', '2022-11-02', 2);
INSERT INTO `palestraBDprj`.`composizione` (`serie`, `ripetizioni`, `ordinenellascheda`, `nomeesercizio`, `dataassegnazione`, `cliente_id`) VALUES (3, 120, 1, 'PLANK', '2022-11-01', 1);
INSERT INTO `palestraBDprj`.`composizione` (`serie`, `ripetizioni`, `ordinenellascheda`, `nomeesercizio`, `dataassegnazione`, `cliente_id`) VALUES (4, 25, 2, 'SIT UP', '2022-11-01', 1);
INSERT INTO `palestraBDprj`.`composizione` (`serie`, `ripetizioni`, `ordinenellascheda`, `nomeesercizio`, `dataassegnazione`, `cliente_id`) VALUES (3, 15, 3, 'CRUNCHES', '2022-11-01', 1);
INSERT INTO `palestraBDprj`.`composizione` (`serie`, `ripetizioni`, `ordinenellascheda`, `nomeesercizio`, `dataassegnazione`, `cliente_id`) VALUES (2, 10, 4, 'PUSH UP', '2022-11-01', 1);
INSERT INTO `palestraBDprj`.`composizione` (`serie`, `ripetizioni`, `ordinenellascheda`, `nomeesercizio`, `dataassegnazione`, `cliente_id`) VALUES (3, 90, 1, 'PLANK', '2022-10-01', 1);
INSERT INTO `palestraBDprj`.`composizione` (`serie`, `ripetizioni`, `ordinenellascheda`, `nomeesercizio`, `dataassegnazione`, `cliente_id`) VALUES (4, 20, 2, 'SIT UP', '2022-10-01', 1);
INSERT INTO `palestraBDprj`.`composizione` (`serie`, `ripetizioni`, `ordinenellascheda`, `nomeesercizio`, `dataassegnazione`, `cliente_id`) VALUES (3, 15, 3, 'CRUNCHES', '2022-10-01', 1);
INSERT INTO `palestraBDprj`.`composizione` (`serie`, `ripetizioni`, `ordinenellascheda`, `nomeesercizio`, `dataassegnazione`, `cliente_id`) VALUES (1, 10, 1, 'CORSA', '2022-09-01', 1);
INSERT INTO `palestraBDprj`.`composizione` (`serie`, `ripetizioni`, `ordinenellascheda`, `nomeesercizio`, `dataassegnazione`, `cliente_id`) VALUES (3, 15, 2, 'CRUNCHES', '2022-09-01', 1);
INSERT INTO `palestraBDprj`.`composizione` (`serie`, `ripetizioni`, `ordinenellascheda`, `nomeesercizio`, `dataassegnazione`, `cliente_id`) VALUES (1, 12, 3, 'PLANK', '2022-09-01', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `palestraBDprj`.`utenti`
-- -----------------------------------------------------
START TRANSACTION;
USE `palestraBDprj`;
INSERT INTO `palestraBDprj`.`utenti` (`nome`, `cognome`, `password`, `ruolo`) VALUES ('Roosevelt', 'Emberson', '075decbd1c303544ce05fc54e3572a85', 'cliente');
INSERT INTO `palestraBDprj`.`utenti` (`nome`, `cognome`, `password`, `ruolo`) VALUES ('Bab', 'Sange', '34cafdb9a33d05a68ac5cecdb76b0085', 'cliente');
INSERT INTO `palestraBDprj`.`utenti` (`nome`, `cognome`, `password`, `ruolo`) VALUES ('Ansley', 'Torri', '41cfea06c6b7c450ce86054bf3d2229c', 'personalTrainer');
INSERT INTO `palestraBDprj`.`utenti` (`nome`, `cognome`, `password`, `ruolo`) VALUES ('Pippo', 'Rossi', '4a057a33f1d8158556eade51342786c6', 'amministratore');

COMMIT;


-- -----------------------------------------------------
-- Data for table `palestraBDprj`.`macchinario`
-- -----------------------------------------------------
START TRANSACTION;
USE `palestraBDprj`;
INSERT INTO `palestraBDprj`.`macchinario` (`nomemacchinario`) VALUES ('LAT MACHINE');
INSERT INTO `palestraBDprj`.`macchinario` (`nomemacchinario`) VALUES ('LEG PRESS');
INSERT INTO `palestraBDprj`.`macchinario` (`nomemacchinario`) VALUES ('LEG EXTENSION');
INSERT INTO `palestraBDprj`.`macchinario` (`nomemacchinario`) VALUES ('MANUBRI');
INSERT INTO `palestraBDprj`.`macchinario` (`nomemacchinario`) VALUES ('BILANCIERE');
INSERT INTO `palestraBDprj`.`macchinario` (`nomemacchinario`) VALUES ('CYCLETTE');
INSERT INTO `palestraBDprj`.`macchinario` (`nomemacchinario`) VALUES ('SBARRA');
INSERT INTO `palestraBDprj`.`macchinario` (`nomemacchinario`) VALUES ('TAPIS ROULANT');

COMMIT;


-- -----------------------------------------------------
-- Data for table `palestraBDprj`.`esercizio`
-- -----------------------------------------------------
START TRANSACTION;
USE `palestraBDprj`;
INSERT INTO `palestraBDprj`.`esercizio` (`nomeesercizio`, `macchinario_nomemacchinario`) VALUES ('LAT MACHINE AVANTI', 'LAT MACHINE');
INSERT INTO `palestraBDprj`.`esercizio` (`nomeesercizio`, `macchinario_nomemacchinario`) VALUES ('LAT MACHINE DIETRO', 'LAT MACHINE');
INSERT INTO `palestraBDprj`.`esercizio` (`nomeesercizio`, `macchinario_nomemacchinario`) VALUES ('IPERTENSIONI', NULL);
INSERT INTO `palestraBDprj`.`esercizio` (`nomeesercizio`, `macchinario_nomemacchinario`) VALUES ('PLANK', NULL);
INSERT INTO `palestraBDprj`.`esercizio` (`nomeesercizio`, `macchinario_nomemacchinario`) VALUES ('JUMPING JACKS', NULL);
INSERT INTO `palestraBDprj`.`esercizio` (`nomeesercizio`, `macchinario_nomemacchinario`) VALUES ('SIT UP', NULL);
INSERT INTO `palestraBDprj`.`esercizio` (`nomeesercizio`, `macchinario_nomemacchinario`) VALUES ('CRUNCHES', NULL);
INSERT INTO `palestraBDprj`.`esercizio` (`nomeesercizio`, `macchinario_nomemacchinario`) VALUES ('PUSH UP', NULL);
INSERT INTO `palestraBDprj`.`esercizio` (`nomeesercizio`, `macchinario_nomemacchinario`) VALUES ('CORSA', 'TAPIS ROULANT');

COMMIT;

-- begin attached script 'deleteSchede'
set global event_scheduler = on;

create event if not exists clean
	on schedule 
		every 7 day
			on completion preserve
		comment 'Rimuove schede di allenamento più vecchie di 3 anni'
	do
		delete from schedadiallenamento where datediff(curdate(), dataassegnazione) > 1092;
-- end attached script 'deleteSchede'

DELIMITER $$

USE `palestraBDprj`$$
DROP TRIGGER IF EXISTS `palestraBDprj`.`schedadiallenamento_BEFORE_INSERT` $$
USE `palestraBDprj`$$
CREATE DEFINER = CURRENT_USER TRIGGER `palestraBDprj`.`schedadiallenamento_BEFORE_INSERT` BEFORE INSERT ON `schedadiallenamento` FOR EACH ROW
BEGIN
	-- Controllo se effettivamente il personal trainer è associato a quel cliente in quel dato momento
    if new.cliente_id not in (select cliente.id from cliente where cliente.personaltrainer_id = new.personaltrainer_id) then
		signal sqlstate '45001' set message_text = 'Non si ha affiliato questo cliente';
    end if;
END$$


USE `palestraBDprj`$$
DROP TRIGGER IF EXISTS `palestraBDprj`.`sessione_BEFORE_INSERT` $$
USE `palestraBDprj`$$
CREATE DEFINER = CURRENT_USER TRIGGER `palestraBDprj`.`sessione_BEFORE_INSERT` BEFORE INSERT ON `sessione` FOR EACH ROW
BEGIN
	declare dataFine date;
    
    set dataFine := (select datafine from schedadiallenamento as sda where sda.cliente_id = new.cliente_id and sda.dataassegnazione = new.dataassegnazione);

	if dataFine is not null and dataFine != curdate() then
		signal sqlstate '45001' set message_text = 'Scheda di allenamento allenamento non valida';
	end if;
    
    if new.datasessione < new.dataassegnazione then
		signal sqlstate '45001' set message_text = 'Data sessione non valida per la scheda di allenemento voluta';
    end if;

END$$


USE `palestraBDprj`$$
DROP TRIGGER IF EXISTS `palestraBDprj`.`composizione_BEFORE_INSERT` $$
USE `palestraBDprj`$$
CREATE DEFINER = CURRENT_USER TRIGGER `palestraBDprj`.`composizione_BEFORE_INSERT` BEFORE INSERT ON `composizione` FOR EACH ROW
BEGIN
	if (select datafine from schedadiallenamento where new.cliente_id = cliente_id and new.dataassegnazione = dataassegnazione) is not null then
		signal sqlstate '45001' set message_text = 'Scheda di allenamento vecchia';
    end if;
END$$


USE `palestraBDprj`$$
DROP TRIGGER IF EXISTS `palestraBDprj`.`macchinario_BEFORE_INSERT` $$
USE `palestraBDprj`$$
CREATE DEFINER = CURRENT_USER TRIGGER `palestraBDprj`.`macchinario_BEFORE_INSERT` BEFORE INSERT ON `macchinario` FOR EACH ROW
BEGIN
	if(new.nomemacchinario not in (select nomemacchinario from storico_macchinario)) then
		insert into storico_macchinario value (new.nomemacchinario);
    end if;
END$$


USE `palestraBDprj`$$
DROP TRIGGER IF EXISTS `palestraBDprj`.`esercizio_BEFORE_INSERT` $$
USE `palestraBDprj`$$
CREATE DEFINER = CURRENT_USER TRIGGER `palestraBDprj`.`esercizio_BEFORE_INSERT` BEFORE INSERT ON `esercizio` FOR EACH ROW
BEGIN
	if(new.nomeesercizio not in (select nomeesercizio from storico_esercizio)) then
		insert into storico_esercizio value (new.nomeesercizio, new.macchinario_nomemacchinario);
    end if;
END$$
