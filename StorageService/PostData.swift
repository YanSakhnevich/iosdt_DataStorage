import UIKit

public struct PostData {
    public var title: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    
}

public let post1 = PostData(
    title: """
"Десять лет за десять минут": Oxxxymiron представил новые трек и клип
""",
    description: """
    Российский хип-хоп исполнитель Oxxxymiron (Мирон Федоров) представил в Сети новый трек под названием 'Кто убил Марка?' и опубликовал на YouTube клип на него.
    В треке Oxxxymiron рассказывает о событиях, произошедших и тронувших его за последние десять лет. Рэпер вспоминает о конфликте с Ромой Жиганом, случившемся в 2011 году, о том, как с нуля строил карьеру, рэп-баттлах, а также размышляет о жизни и делится со слушателями внутренними переживаниями.
    Десятиминутный ролик, снятый Тимой ROHO, как раз начинается с видео, на котором Жиган дает Федорову пощечину после того, как тот попросил прощения. Дальше на фоне других архивных кадров Oxxxymiron продолжает зачитывать рэп.
    За три часа с момента релиза клип набрал почти 600 тысяч просмотров, 200 тысяч лайков и 20 с половиной тысяч комментариев. Поклонники поздравили Oxxxymiron с релизом и похвалили за то, что он поделился личным.
""",
    image: "1",
    likes: 83765,
    views: 112876)


public let post2 = PostData(
    title: """
Группа Limp Bizkit выпустила первый за десять лет альбом
""",
    description: """
    Группа Limp Bizkit выпустила первый за десять лет альбом — "Stil sucks". О его выходе музыканты сообщили в своем Instagram-аккаунте.
    Пластинка доступна на цифровых платформах.
    Известно, что рокеры сначала хотели назвать новый сборник "Stampede of the Disco Elephants", однако в итоге его переименовали. В альбом вошло 12 песен, среди них трек "Dad vibes". Он был выпущен в качестве сингла в конце сентября. Однако фанаты группы могли услышать его ранее — Limp Bizkit представила его в июле на фестивале Lollapalooza.
    Предыдущий диск "Gold Cobra" у команды вышел в 2011 году.
    Американская рэп-метал группа Limp Bizkit была основана в 1994 году. Команда трижды номинировалась на премию "Грэмми".
""",
    image: "2",
    likes: 6505,
    views: 12065)


public let post3 = PostData(
    title: """
macOS Monterey уже здесь
""",
    description: """
    Передовые функции macOS Monterey открывают новые способы общения, помогают справляться с делами и обеспечивают идеальное взаимодействие между устройствами Apple.
    Новые функции аудио и видео в FaceTime делают общение более естественным. А новые инструменты Непрерывности, такие как AirPlay на Mac, обеспечивают ещё более удобную работу сразу с несколькими устройствами Apple.
    Функции «Онлайн-текст» и «Визуальный поиск» используют новые возможности искусственного интеллекта для удобного поиска информации. В браузере Safari появилась возможность объединять вкладки в группы. А ещё на Mac стали доступны Быстрые команды для автоматизации различных действий. Позже этой осенью пользователи Mac смогут разделить с друзьями удовольствие от просмотра и прослушивания контента с помощью функции SharePlay в FaceTime.
    А функция Universal Control позволит легко переключаться между Mac и iPad. Система macOS Monterey доступна уже сегодня в формате бесплатного обновления ПО на компьютерах Mac с чипом Apple и Mac на основе процессоров Intel.
""",
    image: "3",
    likes: 6678,
    views: 88755)


public let post4 = PostData(
    title: """
«Лейкерс» потеряли Леброна Джеймса из-за травмы
""",
    description: """
    Форвард «Лос-Анджелес Лейкерс» Леброн Джеймс пропустит как минимум одну неделю из-за растяжения мышц брюшной полости, сообщает инсайдер Шэмс Чарания на своей странице в «Твиттере».
    Медицинский штаб «Лейкерс» хочет проявить осторожность при восстановлении игрока, поэтому не будет форсировать процесс восстановления Джеймса. Ранее у Леброна были проблемы с голеностопом, из-за чего он пропустил два матча регулярного чемпионата НБА. «Лейкерс» занимают первое место в Западной конференции с результатом 5-3. 36-летний Леброн в нынешнем сезоне набирает 24,8 очка, 5,5 подбора, 7,0 передачи, 2,3 перехвата и 0,8 блок-шота в среднем за игру.
    Тревор Ариза (голеностоп), Тэйлен Хортон-Такер (подколенное сухожилие), Кендрик Нанн (колено) и Уэйн Эллингтон (подколенное сухожилие) — другие травмированные игроки «Лейкерс», которые не выходили на площадку в этом сезоне.
""",
    image: "4",
    likes: 9987,
    views: 88764)

public let postArray: [PostData] = [post1, post2, post3, post4]