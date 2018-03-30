model CyberCabinet


-- @package cabinet

-- @datatype PositiveInteger range(0,*)
-- @datatype Nir @constraint match('[1-4]\d\d((0[1-9])|(1[0-2]))\d[0-9AB]\d{8}')
-- @datatype Date
-- @datatype IntervenantId: match('\d{3}')
-- @datatype CodePostal: match('\d{5}')

enum SexeId {
    masculin,       -- @value 'M'
    feminin         -- @value 'F'
}

class Cabinet
attributes
    nom : String
end

class Infirmier
attributes
    id : String -- @type IntervenantId  @xml:attribute
    nom : String
    prenom : String
    photo : String  -- @type URI
end

class Patient
attributes
    nom : String
    prenom : String
    sexe : SexeId
    naissance : String -- @type Date
    numero : String -- @type Nir
end

class Visite
attributes
    date : String -- @type Date @xsl:attribute
    -- @xsl -> intervenant : IntervenantId
end




class Adresse
attributes
    etage : Integer -- @type PositiveInteger
    numero : Integer -- @type PositiveInteger
    rue : String
    ville : String
    codePostal : String -- @type CodePostal
end

composition EstCabinetLocaliseA between
    Cabinet[0..1] role cabinet
    Adresse[1] role adresse
end

composition EstInfirmierLocaliseA between
    Infirmier[0..1] role infirmier
    Adresse[1] role adresse
end

composition EstPatientLocaliseA between
    Patient[0..1] role patient
    Adresse[1] role adresse
end

composition EstSuiviLorsDe between
    Patient[1] role patient
    Visite[1] role visite
end

composition Emploie between
    Cabinet[1] role cabinet
    Infirmier[*] role infirmiers
end

composition Soigne between
    Cabinet[1] role cabinet
    Patient[*] role patients
end

composition Comporte between
    Visite[*] role visite
    Acte[*] role actes
end

association EstAssureePar between
    Visite[*] role visites
    Infirmier[*] role intervenant --@navigable
end

-- @package actes

class Type
attributes
    id : String   -- @xml:attribute
    description : String
end

class Acte     ----------- > reference aux actes autre fichiers
attributes
    id : Integer    -- @xml:attribute
    cle : String    -- @xml:attribute
    coef : Integer  -- @xml:attribute
    description : String
end

association Regroupe between
    Type[1] role type
    Acte[*] role actes -- navigable
end


