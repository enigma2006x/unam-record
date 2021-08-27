**CLASS**

# `UserDataViewModel`

```swift
class UserDataViewModel
```

Defines the `UserDataViewModel` model that is responsible for defining the Profile response response.

```swift
    @Published var accountImage = UIImage()
    @Published var accountID = ""
    @Published var accountFullName = ""
    @Published var isShowingAcademicItems = false
    @Published var isShowingSubjectItems = false
    @Published var subjectSections = [SubjectSection]()
    @Published var academicItems = [AcademicItem]()
```