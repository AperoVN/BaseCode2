Conventions
CCreated by Đinh Văn Trình on 27/06/2022.

---------------------------------------------------------
# File Formating
1. Cấu trúc 1 file .swift
`
class ViewController: UIViewController {
// MARK: - Outlets
// MARK: - Static Constants
// MARK: - Static/Class Variables
// MARK: - Static/Class Functions
// MARK: - Constants
// MARK: - Variables
// MARK: - Init/Deinit
// MARK: - Override Functions
// MARK: - Instance Functions
// MARK: - Actions + Selectors
}
`

`
// MARK: - Textfield Delegates
extension ViewController: UITextFieldDelegate{}
`
2. Ở mỗi phần của file thì mình sẽ khai báo thứ tự độ ưu tiên các cấp độ truy cập.
`
Open
Public
Internal
Fileprivate
Private
`

3. Sử dụng TODO và FIXME
`
// TODO: - Để khai báo nhiệm vụ của 1 biến hoặc 1 hàm
// FIXME: - Để log warning hoặc bugs
`

---------------------------------------------------------
# Naming
1. Sử dụng tiếng anh để đặt tên
2. Tên cần rõ ràng và nói lên được ý nghĩa sử dụng.
3. Sử dụng cú pháp lạc đà (camel case).
4.  Viết hoa chữ cái đầu tiên cho tên của các kiểu dữ liệu tự tạo, class, protocol nhưng lại viết thường chữ cái đầu tiên cho tên hàm, biến.
5. Tránh sử dụng các từ viết tắt không thông dụng, nếu bạn dùng từ viết tắt thì hãy ghi bằng chữ IN HOA.
6. Nếu dùng từ viết tắt thì phải thống nhất từ trên xuống dưới và trong toàn bộ project.
7. Sử dụng các từ ngữ tránh gây nhầm lẫn, có ý nghĩa mơ hồ cho người đọc code tại nơi sử dụng. 
` 
func remove(at position: Index) -> Element 
employees.remove(at: x)
`

8.  Đặt tên cho các tham số của hàm nên có mối liên hệ với nhau và nói lên được xử lý của hàm đó.
`
func addObserver(_ observer: NSObject, forKeyPath path: String) 
grid.addObserver(self, forKeyPath: graphics) // rõ ràng
`

---------------------------------------------------------
# Code Formatting
1. Mỗi dòng không được quá 160 ký tự.
2. Dấu `{` nằm cùng hàng và cách 1 space với khai báo trước đó. 
override func viewDidLoad() {
}

3. Khi khai báo biến, hằng, hàm… không thêm space trước dấu `:`. 
`
let pirateViewController: PirateViewController
let ninjaDictionary: [String: AnyObject] = [
"fightLikeDairyFarmer": false,
"disgusting": true
]
`

4. Sử dụng 1 space sau giấu phẩy  `,`. VD:
`
let myArray = [1, 2, 3, 4, 5]
`

5. Sử dụng 1 space trước và sau các operator `+` , `-` ,  `==` , `->`.
`
let myValue = 20 + (30 / 2) * 3
`

6. Không dùng space trước và sau dấu đóng và mở ngoặc `()`.
`
(30 / 2)
`

7. Khi khai báo function có nhiều params, xuống dòng cho từng param.
`
func myFunctionWithManyParameters(parameterOne: String,
parameterTwo: String,
parameterThree: String) {
print("\(parameterOne) \(parameterTwo) \(parameterThree)")
}
`

8. Sử dụng mảng và dictionary trên nhiều dòng.
`
someFunctionWithABunchOfArguments(
someStringArgument: "hello I am a string",
someArrayArgument: [
"dadada daaaa daaaa dadada daaaa daaaa dadada daaaa daaaa",
"string one is crazy - what is it thinking?"
],
someDictionaryArgument: [
"dictionary key 1": "some value 1, but also some more text here",
"dictionary key 2": "some value 2"
],
someClosure: { parameter1 in
print(parameter1)
})
`

---------------------------------------------------------
# Coding Style
1. Ưu tiên dùng let hơn var.
2. Ưu tiên sử dụng ` map, filter, reduce `… khi dùng collections.
3. Không xài kiểu dữ liệu nếu có thể ngầm định hiểu được Kiểu dữ liệu. VD: ` var name = “John”. `
4. Khi viết 1 function trả về 2 giá trị khác nhau thì ưu tiên dùng Tuple. Nếu nhiều hơn 2 giá trị thì chuyển các giá trị thành 1 class hoặc struct.
5. Ưu tiên dùng final khi khai báo 1 class.
6. Xài else if và try catch.
`
if someBoolean {
} else { //Else phải nằm trên dòng với dấu đóng ngoặc
}
`
`
do {
let fileContents = try readFile("filename.txt")
} catch {
print(error)
}
`

7. Ưu tiên các giá trị tự suy luận.
view.backgroundColor = .red  // `Thay vì UIColor.red`
let toView = context.view(forKey: .to)
let view = UIView(frame: .zero) // `Thay vì CGRect.zero`

8. Return và break sớm nhất có thể (loop và function)
9. Sử dụng hàm getter ngầm.
`
var myGreatProperty: Int {
return 4
}
`
Chứ không xài
`
var myGreatProperty: Int {
get {
return 4
}
}
`

10. Sử dụng `self` khi thật sự cần thiết.

---------------------------------------------------------
# Access Modifiers
1. Khai báo access modifier keyword đầu tiên khi khai báo. VD: ` private static let myPrivateNumber: Int `

---------------------------------------------------------
# Optional
1. Không sử dụng as! và try!
2. Không sử dụng Force-Unwrapping khi optional (!). Thay vào đó xài if let hoặc guard.
3. Để check nil thì nên dùng 
`
if someOptional != nil {
// do something
}
`

---------------------------------------------------------
# Delegate
1. Khai báo weak với delegate. VD: ` weak open var delegate: UITextFieldDelegate?  `
2. Khi tạo một hàm delegate nào đó, tên hàm nên ẩn đi tham số đầu tiên bằng ký tự `_`
`
func namePickerView(_ namePickerView: NamePickerView, didSelectName name: String)
func namePickerViewShouldReload(_ namePickerView: NamePickerView) -> Bool
`

---------------------------------------------------------
# Closure
1. Sử dụng [weak self] trong closure.
`
myFunctionWithEscapingClosure() { [weak self] (error) -> Void in
guard let strongSelf = self else {
return
}
}
`

2. Với các closure gọi ngầm không biết thời gian xác định hoàn thành. Sử dụng @Escaping khi khai báo closure.
`
func getSumOf(numbers: [Int], completion: @escaping (Int) -> Void) {
}
`

---------------------------------------------------------
# Array
1. Ưu tiên dùng `for item in items` hoặc ` for (index, value) in items.enumerated() `
2. Ưu tiên dùng  `.first, .last `
3. KHông sử dụng ` += ` hoặc ` + `với array. Thay thế sử dụng ` .append(), .append(contentsOf:), let myNewArray = [arr1, arr2].joined()`

---------------------------------------------------------
# Documentation

class Human {
/**
This method feeds a certain food to a person.

- parameter food: The food you want to be eaten.
- parameter person: The person who should eat the food.
- returns: True if the food was eaten by the person; false otherwise.
*/
func feed(_ food: Food, to person: Human) -> Bool {
// ...
}
}



