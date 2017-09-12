<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="17008000">
	<Item Name="My Computer" Type="My Computer">
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="AEROTECstageAPI" Type="Folder" URL="../AEROTECstageAPI">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="Examples" Type="Folder" URL="../Examples">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="main.vi" Type="VI" URL="../main.vi"/>
		<Item Name="testingImagesROI.vi" Type="VI" URL="../testingImagesROI.vi"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="Application Directory.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Application Directory.vi"/>
				<Item Name="BuildHelpPath.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/BuildHelpPath.vi"/>
				<Item Name="Check if File or Folder Exists.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Check if File or Folder Exists.vi"/>
				<Item Name="Check Special Tags.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Check Special Tags.vi"/>
				<Item Name="Clear Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Clear Errors.vi"/>
				<Item Name="Color to RGB.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/colorconv.llb/Color to RGB.vi"/>
				<Item Name="Convert property node font to graphics font.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Convert property node font to graphics font.vi"/>
				<Item Name="Details Display Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Details Display Dialog.vi"/>
				<Item Name="DialogType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogType.ctl"/>
				<Item Name="DialogTypeEnum.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogTypeEnum.ctl"/>
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="Error Code Database.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Code Database.vi"/>
				<Item Name="ErrWarn.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/ErrWarn.ctl"/>
				<Item Name="eventvkey.ctl" Type="VI" URL="/&lt;vilib&gt;/event_ctls.llb/eventvkey.ctl"/>
				<Item Name="Find Tag.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Find Tag.vi"/>
				<Item Name="Format Message String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Format Message String.vi"/>
				<Item Name="General Error Handler Core CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler Core CORE.vi"/>
				<Item Name="General Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler.vi"/>
				<Item Name="Get String Text Bounds.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Get String Text Bounds.vi"/>
				<Item Name="Get Text Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Get Text Rect.vi"/>
				<Item Name="GetHelpDir.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetHelpDir.vi"/>
				<Item Name="GetRTHostConnectedProp.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetRTHostConnectedProp.vi"/>
				<Item Name="Image Type" Type="VI" URL="/&lt;vilib&gt;/vision/Image Controls.llb/Image Type"/>
				<Item Name="IMAQ Create" Type="VI" URL="/&lt;vilib&gt;/vision/Basics.llb/IMAQ Create"/>
				<Item Name="IMAQ Image.ctl" Type="VI" URL="/&lt;vilib&gt;/vision/Image Controls.llb/IMAQ Image.ctl"/>
				<Item Name="IMAQ Overlay Points" Type="VI" URL="/&lt;vilib&gt;/vision/Overlay.llb/IMAQ Overlay Points"/>
				<Item Name="IMAQ ReadFile" Type="VI" URL="/&lt;vilib&gt;/vision/Files.llb/IMAQ ReadFile"/>
				<Item Name="Longest Line Length in Pixels.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Longest Line Length in Pixels.vi"/>
				<Item Name="LVBoundsTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVBoundsTypeDef.ctl"/>
				<Item Name="LVRectTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVRectTypeDef.ctl"/>
				<Item Name="NI_FileType.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/lvfile.llb/NI_FileType.lvlib"/>
				<Item Name="NI_PackedLibraryUtility.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/LVLibp/NI_PackedLibraryUtility.lvlib"/>
				<Item Name="Not Found Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Not Found Dialog.vi"/>
				<Item Name="Search and Replace Pattern.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Search and Replace Pattern.vi"/>
				<Item Name="Set Bold Text.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set Bold Text.vi"/>
				<Item Name="Set String Value.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set String Value.vi"/>
				<Item Name="Simple Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Simple Error Handler.vi"/>
				<Item Name="TagReturnType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/TagReturnType.ctl"/>
				<Item Name="Three Button Dialog CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog CORE.vi"/>
				<Item Name="Three Button Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog.vi"/>
				<Item Name="Trim Whitespace.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Trim Whitespace.vi"/>
				<Item Name="whitespace.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/whitespace.ctl"/>
			</Item>
			<Item Name="Abort.vi" Type="VI" URL="../Motion/Abort.vi"/>
			<Item Name="AbortMultiple.vi" Type="VI" URL="../Motion/AbortMultiple.vi"/>
			<Item Name="AbortSingle.vi" Type="VI" URL="../Motion/AbortSingle.vi"/>
			<Item Name="Aerotech.Ensemble.dll" Type="Document" URL="../Bin/Aerotech.Ensemble.dll"/>
			<Item Name="Aerotech.Ensemble.LabVIEW.dll" Type="Document" URL="../Bin/Aerotech.Ensemble.LabVIEW.dll"/>
			<Item Name="AlertError.vi" Type="VI" URL="../Utility/AlertError.vi"/>
			<Item Name="AxisControl.ctl" Type="VI" URL="../Utility/AxisControl.ctl"/>
			<Item Name="AxisDataResults.ctl" Type="VI" URL="../Scope/AxisDataResults.ctl"/>
			<Item Name="AxisDiagPacket.ctl" Type="VI" URL="../Status/AxisDiagPacket.ctl"/>
			<Item Name="Connect.vi" Type="VI" URL="../Initialize/Connect.vi"/>
			<Item Name="ControllerDataResults.ctl" Type="VI" URL="../Scope/ControllerDataResults.ctl"/>
			<Item Name="ControllerDiagPacket.ctl" Type="VI" URL="../Status/ControllerDiagPacket.ctl"/>
			<Item Name="ConvertDiagPacket.vi" Type="VI" URL="../Status/ConvertDiagPacket.vi"/>
			<Item Name="Disable.vi" Type="VI" URL="../Motion/Disable.vi"/>
			<Item Name="DisableMultiple.vi" Type="VI" URL="../Motion/DisableMultiple.vi"/>
			<Item Name="DisableSingle.vi" Type="VI" URL="../Motion/DisableSingle.vi"/>
			<Item Name="Disconnect.vi" Type="VI" URL="../Initialize/Disconnect.vi"/>
			<Item Name="Enable.vi" Type="VI" URL="../Motion/Enable.vi"/>
			<Item Name="EnableMultiple.vi" Type="VI" URL="../Motion/EnableMultiple.vi"/>
			<Item Name="EnableSingle.vi" Type="VI" URL="../Motion/EnableSingle.vi"/>
			<Item Name="ExecuteCommand.vi" Type="VI" URL="../Commands/ExecuteCommand.vi"/>
			<Item Name="ExecuteProgram.vi" Type="VI" URL="../Commands/ExecuteProgram.vi"/>
			<Item Name="FaultAck.vi" Type="VI" URL="../Motion/FaultAck.vi"/>
			<Item Name="FaultAckMultiple.vi" Type="VI" URL="../Motion/FaultAckMultiple.vi"/>
			<Item Name="FaultAckSingle.vi" Type="VI" URL="../Motion/FaultAckSingle.vi"/>
			<Item Name="FileDelete.vi" Type="VI" URL="../File/FileDelete.vi"/>
			<Item Name="FileFreeSpace.vi" Type="VI" URL="../File/FileFreeSpace.vi"/>
			<Item Name="FileGetInfo.vi" Type="VI" URL="../File/FileGetInfo.vi"/>
			<Item Name="FileList.vi" Type="VI" URL="../File/FileList.vi"/>
			<Item Name="FileOnController.vi" Type="VI" URL="../File/FileOnController.vi"/>
			<Item Name="FileOptimize.vi" Type="VI" URL="../File/FileOptimize.vi"/>
			<Item Name="FileRetrieve.vi" Type="VI" URL="../File/FileRetrieve.vi"/>
			<Item Name="FileSend.vi" Type="VI" URL="../File/FileSend.vi"/>
			<Item Name="Freerun.vi" Type="VI" URL="../Motion/Freerun.vi"/>
			<Item Name="FreerunMultiple.vi" Type="VI" URL="../Motion/FreerunMultiple.vi"/>
			<Item Name="FreerunSingle.vi" Type="VI" URL="../Motion/FreerunSingle.vi"/>
			<Item Name="GetAxisIndex.vi" Type="VI" URL="../Utility/GetAxisIndex.vi"/>
			<Item Name="GetAxisNames.vi" Type="VI" URL="../Utility/GetAxisNames.vi"/>
			<Item Name="GetAxisNumber.vi" Type="VI" URL="../Utility/GetAxisNumber.vi"/>
			<Item Name="GetAxisParameter.vi" Type="VI" URL="../Parameters/GetAxisParameter.vi"/>
			<Item Name="GetAxisParameterDouble.vi" Type="VI" URL="../Parameters/GetAxisParameterDouble.vi"/>
			<Item Name="GetAxisParameterFloat.vi" Type="VI" URL="../Parameters/GetAxisParameterFloat.vi"/>
			<Item Name="GetAxisParameterInteger.vi" Type="VI" URL="../Parameters/GetAxisParameterInteger.vi"/>
			<Item Name="GetAxisParameterLong.vi" Type="VI" URL="../Parameters/GetAxisParameterLong.vi"/>
			<Item Name="GetAxisParameterString.vi" Type="VI" URL="../Parameters/GetAxisParameterString.vi"/>
			<Item Name="GetScopeData.vi" Type="VI" URL="../Scope/GetScopeData.vi"/>
			<Item Name="GetSystemParameter.vi" Type="VI" URL="../Parameters/GetSystemParameter.vi"/>
			<Item Name="GetSystemParameterDouble.vi" Type="VI" URL="../Parameters/GetSystemParameterDouble.vi"/>
			<Item Name="GetSystemParameterFloat.vi" Type="VI" URL="../Parameters/GetSystemParameterFloat.vi"/>
			<Item Name="GetSystemParameterInteger.vi" Type="VI" URL="../Parameters/GetSystemParameterInteger.vi"/>
			<Item Name="GetSystemParameterLong.vi" Type="VI" URL="../Parameters/GetSystemParameterLong.vi"/>
			<Item Name="GetSystemParameterString.vi" Type="VI" URL="../Parameters/GetSystemParameterString.vi"/>
			<Item Name="GetTaskParameter.vi" Type="VI" URL="../Parameters/GetTaskParameter.vi"/>
			<Item Name="GetTaskParameterDouble.vi" Type="VI" URL="../Parameters/GetTaskParameterDouble.vi"/>
			<Item Name="GetTaskParameterFloat.vi" Type="VI" URL="../Parameters/GetTaskParameterFloat.vi"/>
			<Item Name="GetTaskParameterInteger.vi" Type="VI" URL="../Parameters/GetTaskParameterInteger.vi"/>
			<Item Name="GetTaskParameterLong.vi" Type="VI" URL="../Parameters/GetTaskParameterLong.vi"/>
			<Item Name="GetTaskParameterString.vi" Type="VI" URL="../Parameters/GetTaskParameterString.vi"/>
			<Item Name="GetVersion.vi" Type="VI" URL="../Utility/GetVersion.vi"/>
			<Item Name="Home.vi" Type="VI" URL="../Motion/Home.vi"/>
			<Item Name="HomeMultiple.vi" Type="VI" URL="../Motion/HomeMultiple.vi"/>
			<Item Name="HomeSingle.vi" Type="VI" URL="../Motion/HomeSingle.vi"/>
			<Item Name="MoveInc.vi" Type="VI" URL="../Motion/MoveInc.vi"/>
			<Item Name="MoveIncMultiple.vi" Type="VI" URL="../Motion/MoveIncMultiple.vi"/>
			<Item Name="MoveIncSingle.vi" Type="VI" URL="../Motion/MoveIncSingle.vi"/>
			<Item Name="mscorlib" Type="VI" URL="mscorlib">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="NewDiagPacketArrivedCallback.vi" Type="VI" URL="../Status/NewDiagPacketArrivedCallback.vi"/>
			<Item Name="nivision.dll" Type="Document" URL="nivision.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="nivissvc.dll" Type="Document" URL="nivissvc.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="Oscillate.vi" Type="VI" URL="../Motion/Oscillate.vi"/>
			<Item Name="ParseError.vi" Type="VI" URL="../Utility/ParseError.vi"/>
			<Item Name="RegisterForDiagPackets.vi" Type="VI" URL="../Status/RegisterForDiagPackets.vi"/>
			<Item Name="Reset.vi" Type="VI" URL="../Initialize/Reset.vi"/>
			<Item Name="RetrieveDiagPacket.vi" Type="VI" URL="../Status/RetrieveDiagPacket.vi"/>
			<Item Name="SaveParameterFile.vi" Type="VI" URL="../Parameters/SaveParameterFile.vi"/>
			<Item Name="SendParameterFile.vi" Type="VI" URL="../Parameters/SendParameterFile.vi"/>
			<Item Name="SetAnalogOutput.vi" Type="VI" URL="../Commands/SetAnalogOutput.vi"/>
			<Item Name="SetAxisParameter.vi" Type="VI" URL="../Parameters/SetAxisParameter.vi"/>
			<Item Name="SetAxisParameterDouble.vi" Type="VI" URL="../Parameters/SetAxisParameterDouble.vi"/>
			<Item Name="SetAxisParameterFloat.vi" Type="VI" URL="../Parameters/SetAxisParameterFloat.vi"/>
			<Item Name="SetAxisParameterInteger.vi" Type="VI" URL="../Parameters/SetAxisParameterInteger.vi"/>
			<Item Name="SetAxisParameterLong.vi" Type="VI" URL="../Parameters/SetAxisParameterLong.vi"/>
			<Item Name="SetAxisParameterString.vi" Type="VI" URL="../Parameters/SetAxisParameterString.vi"/>
			<Item Name="SetDigitalOutput.vi" Type="VI" URL="../Commands/SetDigitalOutput.vi"/>
			<Item Name="SetStatus.vi" Type="VI" URL="../Status/SetStatus.vi"/>
			<Item Name="SetSystemParameter.vi" Type="VI" URL="../Parameters/SetSystemParameter.vi"/>
			<Item Name="SetSystemParameterDouble.vi" Type="VI" URL="../Parameters/SetSystemParameterDouble.vi"/>
			<Item Name="SetSystemParameterFloat.vi" Type="VI" URL="../Parameters/SetSystemParameterFloat.vi"/>
			<Item Name="SetSystemParameterInteger.vi" Type="VI" URL="../Parameters/SetSystemParameterInteger.vi"/>
			<Item Name="SetSystemParameterLong.vi" Type="VI" URL="../Parameters/SetSystemParameterLong.vi"/>
			<Item Name="SetSystemParameterString.vi" Type="VI" URL="../Parameters/SetSystemParameterString.vi"/>
			<Item Name="SetTaskParameter.vi" Type="VI" URL="../Parameters/SetTaskParameter.vi"/>
			<Item Name="SetTaskParameterDouble.vi" Type="VI" URL="../Parameters/SetTaskParameterDouble.vi"/>
			<Item Name="SetTaskParameterFloat.vi" Type="VI" URL="../Parameters/SetTaskParameterFloat.vi"/>
			<Item Name="SetTaskParameterInteger.vi" Type="VI" URL="../Parameters/SetTaskParameterInteger.vi"/>
			<Item Name="SetTaskParameterLong.vi" Type="VI" URL="../Parameters/SetTaskParameterLong.vi"/>
			<Item Name="SetTaskParameterString.vi" Type="VI" URL="../Parameters/SetTaskParameterString.vi"/>
			<Item Name="StopProgram.vi" Type="VI" URL="../Commands/StopProgram.vi"/>
			<Item Name="TriggerScopeCollect.vi" Type="VI" URL="../Scope/TriggerScopeCollect.vi"/>
			<Item Name="UnregisterForDiagPackets.vi" Type="VI" URL="../Status/UnregisterForDiagPackets.vi"/>
			<Item Name="Wait.vi" Type="VI" URL="../Motion/Wait.vi"/>
			<Item Name="WaitMultiple.vi" Type="VI" URL="../Motion/WaitMultiple.vi"/>
			<Item Name="WaitSingle.vi" Type="VI" URL="../Motion/WaitSingle.vi"/>
		</Item>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
