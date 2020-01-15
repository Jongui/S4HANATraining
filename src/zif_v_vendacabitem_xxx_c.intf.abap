interface ZIF_V_VENDACABITEM_XXX_C
  public .


  interfaces /BOBF/IF_LIB_CONSTANTS .

  constants:
    BEGIN OF SC_ACTION,
      BEGIN OF ZV_VENDACABITEM_XXX,
 CREATE_ZV_VENDACABITEM_XXX     TYPE /BOBF/ACT_KEY VALUE '0800274311021EEA88B02D8AC342A1CF',
 DELETE_ZV_VENDACABITEM_XXX     TYPE /BOBF/ACT_KEY VALUE '0800274311021EEA88B02D8AC34321CF',
 LOCK_ZV_VENDACABITEM_XXX       TYPE /BOBF/ACT_KEY VALUE '0800274311021EEA88B02D8AC341E1CF',
 SAVE_ZV_VENDACABITEM_XXX       TYPE /BOBF/ACT_KEY VALUE '0800274311021EEA88B02D8AC343A1CF',
 UNLOCK_ZV_VENDACABITEM_XXX     TYPE /BOBF/ACT_KEY VALUE '0800274311021EEA88B02D8AC34221CF',
 UPDATE_ZV_VENDACABITEM_XXX     TYPE /BOBF/ACT_KEY VALUE '0800274311021EEA88B02D8AC342E1CF',
 VALIDATE_ZV_VENDACABITEM_XXX   TYPE /BOBF/ACT_KEY VALUE '0800274311021EEA88B02D8AC34361CF',
      END OF ZV_VENDACABITEM_XXX,
    END OF SC_ACTION .
  constants:
    BEGIN OF SC_ACTION_ATTRIBUTE,
        BEGIN OF ZV_VENDACABITEM_XXX,
        BEGIN OF LOCK_ZV_VENDACABITEM_XXX,
 GENERIC                        TYPE STRING VALUE 'GENERIC',
 EDIT_MODE                      TYPE STRING VALUE 'EDIT_MODE',
 ALL_NONE                       TYPE STRING VALUE 'ALL_NONE',
 SCOPE                          TYPE STRING VALUE 'SCOPE',
 FORCE_INVALIDATION             TYPE STRING VALUE 'FORCE_INVALIDATION',
 LOCK_PARAMETER_BUFFER          TYPE STRING VALUE 'LOCK_PARAMETER_BUFFER',
        END OF LOCK_ZV_VENDACABITEM_XXX,
        BEGIN OF UNLOCK_ZV_VENDACABITEM_XXX,
 GENERIC                        TYPE STRING VALUE 'GENERIC',
 EDIT_MODE                      TYPE STRING VALUE 'EDIT_MODE',
 ALL_NONE                       TYPE STRING VALUE 'ALL_NONE',
 SCOPE                          TYPE STRING VALUE 'SCOPE',
 FORCE_INVALIDATION             TYPE STRING VALUE 'FORCE_INVALIDATION',
 LOCK_PARAMETER_BUFFER          TYPE STRING VALUE 'LOCK_PARAMETER_BUFFER',
        END OF UNLOCK_ZV_VENDACABITEM_XXX,
      END OF ZV_VENDACABITEM_XXX,
    END OF SC_ACTION_ATTRIBUTE .
  constants:
    BEGIN OF SC_ALTERNATIVE_KEY,
      BEGIN OF ZV_VENDACABITEM_XXX,
 DB_KEY                         TYPE /BOBF/OBM_ALTKEY_KEY VALUE '0800274311021EEA88B02D8AC34481CF',
      END OF ZV_VENDACABITEM_XXX,
    END OF SC_ALTERNATIVE_KEY .
  constants:
    BEGIN OF SC_ASSOCIATION,
      BEGIN OF ZV_VENDACABITEM_XXX,
 LOCK                           TYPE /BOBF/OBM_ASSOC_KEY VALUE '0800274311021EEA88B02D8AC341C1CF',
 MESSAGE                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '0800274311021EEA88B02D8AC34181CF',
 PROPERTY                       TYPE /BOBF/OBM_ASSOC_KEY VALUE '0800274311021EEA88B02D8AC34281CF',
      END OF ZV_VENDACABITEM_XXX,
      BEGIN OF ZV_VENDACABITEM_XXX_LOCK,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '0800274311021EEA88B02D8AC34401CF',
      END OF ZV_VENDACABITEM_XXX_LOCK,
      BEGIN OF ZV_VENDACABITEM_XXX_MESSAGE,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '0800274311021EEA88B02D8AC343E1CF',
      END OF ZV_VENDACABITEM_XXX_MESSAGE,
      BEGIN OF ZV_VENDACABITEM_XXX_PROPERTY,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '0800274311021EEA88B02D8AC34421CF',
      END OF ZV_VENDACABITEM_XXX_PROPERTY,
    END OF SC_ASSOCIATION .
  constants:
    BEGIN OF SC_ASSOCIATION_ATTRIBUTE,
      BEGIN OF ZV_VENDACABITEM_XXX,
        BEGIN OF PROPERTY,
 ALL_NODE_PROPERTY              TYPE STRING VALUE 'ALL_NODE_PROPERTY',
 ALL_NODE_ATTRIBUTE_PROPERTY    TYPE STRING VALUE 'ALL_NODE_ATTRIBUTE_PROPERTY',
 ALL_ASSOCIATION_PROPERTY       TYPE STRING VALUE 'ALL_ASSOCIATION_PROPERTY',
 ALL_ASSOCIATION_ATTRIBUTE_PROP TYPE STRING VALUE 'ALL_ASSOCIATION_ATTRIBUTE_PROP',
 ALL_ACTION_PROPERTY            TYPE STRING VALUE 'ALL_ACTION_PROPERTY',
 ALL_ACTION_ATTRIBUTE_PROPERTY  TYPE STRING VALUE 'ALL_ACTION_ATTRIBUTE_PROPERTY',
 ALL_QUERY_PROPERTY             TYPE STRING VALUE 'ALL_QUERY_PROPERTY',
 ALL_QUERY_ATTRIBUTE_PROPERTY   TYPE STRING VALUE 'ALL_QUERY_ATTRIBUTE_PROPERTY',
 ALL_SUBTREE_PROPERTY           TYPE STRING VALUE 'ALL_SUBTREE_PROPERTY',
        END OF PROPERTY,
      END OF ZV_VENDACABITEM_XXX,
    END OF SC_ASSOCIATION_ATTRIBUTE .
  constants:
    SC_BO_KEY  TYPE /BOBF/OBM_BO_KEY VALUE '0800274311021EEA88B02D72343F01CF' .
  constants:
    SC_BO_NAME TYPE /BOBF/OBM_NAME VALUE 'ZV_VENDACABITEM_XXX' .
  constants:
    BEGIN OF SC_DETERMINATION,
      BEGIN OF ZV_VENDACABITEM_XXX,
 ACTION_AND_FIELD_CONTROL       TYPE /BOBF/DET_KEY VALUE '0800274311021EEA88B02D8AC344A1CF',
      END OF ZV_VENDACABITEM_XXX,
    END OF SC_DETERMINATION .
  constants:
    SC_MODEL_VERSION TYPE /BOBF/CONF_VERSION VALUE '00000' .
  constants:
    BEGIN OF SC_NODE,
 ZV_VENDACABITEM_XXX            TYPE /BOBF/OBM_NODE_KEY VALUE '0800274311021EEA88B02D8AC34121CF',
 ZV_VENDACABITEM_XXX_LOCK       TYPE /BOBF/OBM_NODE_KEY VALUE '0800274311021EEA88B02D8AC341A1CF',
 ZV_VENDACABITEM_XXX_MESSAGE    TYPE /BOBF/OBM_NODE_KEY VALUE '0800274311021EEA88B02D8AC34161CF',
 ZV_VENDACABITEM_XXX_PROPERTY   TYPE /BOBF/OBM_NODE_KEY VALUE '0800274311021EEA88B02D8AC34261CF',
    END OF SC_NODE .
  constants:
    BEGIN OF SC_NODE_ATTRIBUTE,
      BEGIN OF ZV_VENDACABITEM_XXX,
  NODE_DATA                      TYPE STRING VALUE 'NODE_DATA',
  ID                             TYPE STRING VALUE 'ID',
  DATACRIACAO                    TYPE STRING VALUE 'DATACRIACAO',
  CLIENTE                        TYPE STRING VALUE 'CLIENTE',
      END OF ZV_VENDACABITEM_XXX,
    END OF SC_NODE_ATTRIBUTE .
  constants:
    BEGIN OF SC_NODE_CATEGORY,
      BEGIN OF ZV_VENDACABITEM_XXX,
 ROOT                           TYPE /BOBF/OBM_NODE_CAT_KEY VALUE '0800274311021EEA88B02D8AC34141CF',
      END OF ZV_VENDACABITEM_XXX,
    END OF SC_NODE_CATEGORY .
endinterface.