﻿////////////////////////////////////////////////////////////////////////////////
// This file is part of FoxyLink.
// Copyright © 2016-2018 Petro Bazeliuk.
// 
// This program is free software: you can redistribute it and/or modify 
// it under the terms of the GNU Affero General Public License as 
// published by the Free Software Foundation, either version 3 of the License,
// or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful, 
// but WITHOUT ANY WARRANTY; without even the implied warranty of 
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License 
// along with FoxyLink. If not, see <http://www.gnu.org/licenses/agpl-3.0>.
//
////////////////////////////////////////////////////////////////////////////////

#Region FormEventHandlers

&AtServer
Procedure OnCreateAtServer(Cancel, StandardProcessing)
    
    If Parameters.Property("AutoTest") Then
        Return;
    EndIf;
    
    Parameters.Property("Channel", Channel);
    If Parameters.Property("ChannelResources") Then
        
        Attributes = GetAttributes();
        For Each Attribute In Attributes Do
            
            FieldValue = FL_EncryptionClientServer.FieldValueNoException(
                Parameters.ChannelResources, Attribute.Name);
            If ValueIsFilled(FieldValue) Then 
                ThisObject[Attribute.Name] = FieldValue;                   
            EndIf;
            
        EndDo;
        
    EndIf;
     
EndProcedure // OnCreateAtServer()

#EndRegion // FormEventHandlers

#Region FormCommandHandlers

&AtClient
Procedure SaveAndClose(Command)
        
    If IsBlankString(Path) Then
        FL_CommonUseClientServer.NotifyUser(NStr("
                |en='Field {Path} must be filled.';
                |ru='Поле {Путь} должно быть заполнено.';
                |uk='Поле {Шлях} повинно бути заповненим.';
                |en_CA='Field {Path} must be filled.'"), , 
            "Path");
        Return;    
    EndIf;
    
    ResourceRow = Object.ChannelResources.Add();
    ResourceRow.FieldName = "Path";
    ResourceRow.FieldValue = Path;
    
    ResourceRow = Object.ChannelResources.Add();
    ResourceRow.FieldName = "BaseName";
    ResourceRow.FieldValue = BaseName;
    
    ResourceRow = Object.ChannelResources.Add();
    ResourceRow.FieldName = "Extension";
    ResourceRow.FieldValue = Extension;
        
    Close(Object);
    
EndProcedure // SaveAndClose()

#EndRegion // FormCommandHandlers