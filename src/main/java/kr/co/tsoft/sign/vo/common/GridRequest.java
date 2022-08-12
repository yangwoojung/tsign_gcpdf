package kr.co.tsoft.sign.vo.common;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

/*
 * GridRequestVO : 그리드에 의하여 들어오는 기본적인 Request에 대한 정보
 * js dataTable의 기본적인 서버 리퀘스트에 대한 정보를 담는 정보체임
 * 
 * draw: 1
	columns[0][data]: 0
	columns[0][name]: 
	columns[0][searchable]: true
	columns[0][orderable]: true
	columns[0][search][value]: 
	columns[0][search][regex]: false
	columns[1][data]: 1
	columns[1][name]: 
	columns[1][searchable]: true
	columns[1][orderable]: true
	columns[1][search][value]: 
	columns[1][search][regex]: false
	columns[2][data]: 2
	columns[2][name]: 
	columns[2][searchable]: true
	columns[2][orderable]: true
	columns[2][search][value]: 
	columns[2][search][regex]: false
	columns[3][data]: 3
	columns[3][name]: 
	columns[3][searchable]: true
	columns[3][orderable]: true
	columns[3][search][value]: 
	columns[3][search][regex]: false
	columns[4][data]: 4
	columns[4][name]: 
	columns[4][searchable]: true
	columns[4][orderable]: true
	columns[4][search][value]: 
	columns[4][search][regex]: false
	columns[5][data]: 5
	columns[5][name]: 
	columns[5][searchable]: true
	columns[5][orderable]: true
	columns[5][search][value]: 
	columns[5][search][regex]: false
	order[0][column]: 0
	order[0][dir]: asc
	start: 0
	length: 10
	search[value]: 
	search[regex]: false
 */

@JsonIgnoreProperties(ignoreUnknown=true)
public class GridRequest {
	
	/**
     * Draw counter. This is used by DataTables to ensure that the Ajax returns from server-side processing requests are drawn in sequence by DataTables
     * (Ajax requests are asynchronous and thus can return out of sequence). This is used as part of the draw return parameter (see below).
     */
    private int draw = 1;

    /**
     * Paging first record indicator. This is the start point in the current data set (0 index based - i.e. 0 is the first record).
     */
    private int start = 0;

    /**
     * Number of records that the table can display in the current draw. It is expected that the number of records returned will be equal to this number, unless
     * the server has fewer records to return. Note that this can be -1 to indicate that all records should be returned (although that negates any benefits of
     * server-side processing!)
     */
    private int length = 10;

    /**
     * @see Search
     */
    private Search search;

    /**
     * @see Order
     */
    @JsonProperty("order")
    private List<Order> orders;

    /**
     * @see Column
     */
    private List<Column> columns;
    
	private String searchWord;

	private String orderBy;

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public int getDraw() {
		return draw;
	}

	public void setDraw(int draw) {
		this.draw = draw;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getLength() {
		return length;
	}

	public void setLength(int length) {
		this.length = length;
	}

	public Search getSearch() {
		return search;
	}

	public void setSearch(Search search) {
		this.search = search;
	}

	public List<Order> getOrders() {
		return orders;
	}

	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}

	public List<Column> getColumns() {
		return columns;
	}

	public void setColumns(List<Column> columns) {
		this.columns = columns;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
}

class Search {
    /**
     * Global search value. To be applied to all columns which have searchable as true.
     */
    private String value;

    /**
     * <code>true</code> if the global filter should be treated as a regular expression for advanced searching, false otherwise. Note that normally server-side
     * processing scripts will not perform regular expression searching for performance reasons on large data sets, but it is technically possible and at the
     * discretion of your script.
     */
    private boolean regex;

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public boolean isRegex() {
		return regex;
	}

	public void setRegex(boolean regex) {
		this.regex = regex;
	}
}

class Order {
    /**
     * Column to which ordering should be applied. This is an index reference to the columns array of information that is also submitted to the server.
     */
    private int column;

    /**
     * Ordering direction for this column. It will be <code>asc</code> or <code>desc</code> to indicate ascending ordering or descending ordering,
     * respectively.
     */
    private String dir;

	public int getColumn() {
		return column;
	}

	public void setColumn(int column) {
		this.column = column;
	}

	public String getDir() {
		return dir;
	}

	public void setDir(String dir) {
		this.dir = dir;
	}
}

class Column {
    /**
     * Column's data source, as defined by columns.data.
     */
    private String data;

    /**
     * Column's name, as defined by columns.name.
     */
    private String name;

    /**
     * Flag to indicate if this column is searchable (true) or not (false). This is controlled by columns.searchable.
     */
    private boolean searchable;


    /**
     * Flag to indicate if this column is orderable (true) or not (false). This is controlled by columns.orderable.
     */
    private boolean orderable;

    /**
     * Search value to apply to this specific column.
     */
    private Search search;

    /**
     * Flag to indicate if the search term for this column should be treated as regular expression (true) or not (false). As with global search, normally
     * server-side processing scripts will not perform regular expression searching for performance reasons on large data sets, but it is technically possible
     * and at the discretion of your script.
     */
    private boolean regex;

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isSearchable() {
		return searchable;
	}

	public void setSearchable(boolean searchable) {
		this.searchable = searchable;
	}

	public boolean isOrderable() {
		return orderable;
	}

	public void setOrderable(boolean orderable) {
		this.orderable = orderable;
	}

	public Search getSearch() {
		return search;
	}

	public void setSearch(Search search) {
		this.search = search;
	}

	public boolean isRegex() {
		return regex;
	}

	public void setRegex(boolean regex) {
		this.regex = regex;
	}
}
