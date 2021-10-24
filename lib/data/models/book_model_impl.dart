import 'package:TheLibraryApplication/data/models/book_model.dart';
import 'package:TheLibraryApplication/data/vos/book_list_vo.dart';
import 'package:TheLibraryApplication/data/vos/book_vo.dart';
import 'package:TheLibraryApplication/data/vos/books_by_list_name_vo.dart';
import 'package:TheLibraryApplication/data/vos/search_book_vo.dart';
import 'package:TheLibraryApplication/data/vos/shelf_vo.dart';
import 'package:TheLibraryApplication/network/book_data_agent.dart';
import 'package:TheLibraryApplication/network/retrofit_data_agent_impl.dart';
import 'package:TheLibraryApplication/persistance/dao/book_list_dao.dart';
import 'package:TheLibraryApplication/persistance/dao/books_by_list_name_dao.dart';
import 'package:TheLibraryApplication/persistance/dao/impls/book_list_dao_impl.dart';
import 'package:TheLibraryApplication/persistance/dao/impls/books_by_list_name_dao_impl.dart';
import 'package:TheLibraryApplication/persistance/dao/impls/read_books_list_dao_impl.dart';
import 'package:TheLibraryApplication/persistance/dao/impls/shelf_dao_impl.dart';
import 'package:TheLibraryApplication/persistance/dao/read_books_list_dao.dart';
import 'package:TheLibraryApplication/persistance/dao/shelf_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class BookModelImpl extends BookModel {
  BookDataAgent bDataAgent = RetrofitDataAgentImpl();
  static final BookModelImpl _singleton = BookModelImpl._internal();

  factory BookModelImpl() {
    return _singleton;
  }

  BookModelImpl._internal();
  //Daos

  BookListDao bookListDao = BookListDaoImpl();
  BooksByListNameDao booksByListNameDao = BooksByListNameDaoImpl();
  ReadBooksListDao readBooksListDao = ReadBooksListDaoImpl();
  ShelfDao shelfDao = ShelfDaoImpl();
  // GenreDao mGenreDao = GenreDao();
  // ActorDao mActorDao = ActorDao();

  // For Testing Purposes
  void setDaosAndDataAgent(
    BookListDao testBookListDao,
    BooksByListNameDao testBooksByListNameDao,
    ReadBooksListDao testReadBooksListDao,
    ShelfDao testshelfDao,
    BookDataAgent dataAgent,
  ) {
    bookListDao = testBookListDao;
    booksByListNameDao = testBooksByListNameDao;
    readBooksListDao = testReadBooksListDao;
    shelfDao = testshelfDao;
    bDataAgent = dataAgent;
  }

  @override
  Future<List<BookListVO>?>? getBookOverviewList() {
    return bDataAgent.getBookOverviewList()?.then((bookList) {
      if (bookList != null && bookList != []) {
        bookListDao.saveAllBooks(bookList);
      }

      return Future.value(bookList);
    });
  }

  @override
  Future<List<BookVO>?>? getBooksByListName(String listName) {
    return bDataAgent.getBooksByListName(listName)?.then((bookList) {
      booksByListNameDao.saveAllBooksByListName(bookList ?? []);
      return Future.value(bookList);
    });
  }

  // @override
  // Future<List<BookListVO>> getBookOverviewListFromDatabase() {
  //   this.getBookOverviewList();
  //   return bookListDao
  //       .getAllBookListEventStream()
  //       .startWith(bookListDao.getAllBookListStream())
  //       .combineLatest(bookListDao.getAllBookListStream(),
  //           (event, bookList) => bookList as List<BookListVO>)
  //       .first;
  // }

  @override
  Stream<List<BookListVO>> getBookOverviewListFromDatabase() {
    this.getBookOverviewList();
    return bookListDao
        .getAllBookListEventStream()
        .startWith(bookListDao.getAllBookListStream())
        .map((event) => bookListDao.getBookLists());
  }

  @override
  Stream<List<BookVO>> getBooksByListNameFromDatabase(String listname) {
    this.getBooksByListName(listname);
    return booksByListNameDao
        .getAllBooksByListNameEventStream()
        .startWith(booksByListNameDao.getAllBooksByListNameStream())
        .map((event) => booksByListNameDao.getBooksByListName());
  }

  @override
  void saveReadBooks(BookVO book) {
    readBooksListDao.saveReadBooks(book);
  }

  List<BookVO> testSaveReadBooks() {
    return readBooksListDao.getReadBooksList();
  }

  @override
  Stream<List<BookVO>> getReadBooksFromDatabase() {
    return readBooksListDao
        .getAllReadBookListEventStream()
        .startWith(readBooksListDao.getAllBookListStream())
        .map((event) => readBooksListDao.getAllReadBookLists());
  }

  @override
  Future<List<SearchBookVO>?>? getSearchBooksList(String searchText) {
    return bDataAgent.getSearchBooksList(searchText)?.then((bookList) {
      // booksByListNameDao.saveAllBooksByListName(bookList);
      return Future.value(bookList);
    });
  }

  @override
  Stream<List<ShelfVO>> getShelfListFromDatabase() {
    return shelfDao
        .getShelfListEventStream()
        .startWith(shelfDao.getShelfListStream())
        .map((event) => shelfDao.getAllShelfList());
  }

  @override
  void saveShelf(ShelfVO? shelf) {
    shelfDao.saveShelf(shelf);
  }

  List<ShelfVO> testSaveAndDeleteShelf() {
    return shelfDao.getShelfList();
  }

  @override
  void deleteShelf(ShelfVO? shelf) {
    shelfDao.deleteShelf(shelf);
  }
}
