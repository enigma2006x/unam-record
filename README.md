# UNAM Mobile :iphone:

UNAM Mobile is an application that uses the [SIAE Site](https://www.dgae-siae.unam.mx/www_gate.php) and is built with SwiftUI. 

The goal is to make an application using SwiftUI and the MVVM architecture.

The UNAM Mobile application contains the features listed below:

- [Profile View](#profile-view)
- [Academic Record View ](#academic-record-details-view)
- [Academic Record Details View](#academic-record-details-view)
- [Share and Print Academic Record](#share-and-print-academic-record)
- [News View](#news-view)
- [Unit Tests](#unit-tests)
- [UI Tests](#uitests)
- Documentation:
    - [Structs](#structs)
        - SubjectSection
        - AcademicItem
    - [Classes](#classes)
        - UserDataViewModel

The UNAM Mobile is using the endpoints listed below:

- SIAE Sign in https://www.dgae-siae.unam.mx/www_gate.php
- Academic Record Content https://www.dgae-siae.unam.mx/reg_try.html
- Academic Record Details https://www.dgae-siae.unam.mx/www_try.php?cta={accountID}&llave={academicItemKey}&acc=hsa
- UNAM Gazette https://www.gaceta.unam.mx/

## Architecture

UNAM Mobile is applying the [MVVM](https://cocoacasts.com/model-view-viewmodel-in-swift) architecture. 

## Profile View 

The Profile view shows the account used to log into the SIAE system.

<table>
    <tr>
        <th width=340><img src="../main/ProfileView1.png" ></th>
        <th width=340><img src="../main/ProfileView2.png" ></th>
    </tr>
</table>

## Academic Record View 

The Academic Record view shows the academic record of the account used in the SIAE system.

<table>
    <tr>
        <th width=340><img src="../main/AcademicRecord1.png" ></th>
        <th width=340><img src="../main/AcademicRecord2.png" ></th>
    </tr>
</table>

## Academic Record Details View 

The Academic Record Details view shows the details for the selected account and campus.

<table>
    <tr>
        <th width=340><img src="../main/AcademicRecordDetails1.png" ></th>
        <th width=340><img src="../main/AcademicRecordDetails2.png" ></th>
    </tr>
</table>

## Share and Print Academic Record 

The UNAM Mobile allows you to share your Academic Record using different vias like the listed below:
- Email
- Airdrop
- Messages
- WhatsApp
- Slack
- Telegram
- Etc. 

<table>
    <tr>
        <th width=340><img src="../main/PrintView1.png" ></th>
        <th width=340><img src="../main/PrintView3.png" ></th>
    </tr>
</table>

## Unit Tests

The UNAM Mobile contains Unit Tests for evaluate test cases.

<img with=400 src="../main/UnitTests.png" >


## UITests

The UNAM Mobile contains UITests for evaluate test cases.

<img with=400 src="../main/UITests.png" >

## Structs

- [SubjectSection](Documentation/Reference/structs/SubjectSection.md)
- [AcademicItem](Documentation/Reference/structs/AcademicItem.md)

## Classes

- [UserDataViewModel](Documentation/Reference/classes/UserDataViewModel.md)