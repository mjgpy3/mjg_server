window.onload = function() {
  // By convention, we don't want more than one sortable table in a page
  sortableTable = $("table.sortable-table").get()[0];

  if (sortableTable != undefined) {
    setupTableFromElement(sortableTable);
  }
};

var tableRowsAndData = {
  rows: [],
  table: null,
  odd_class: "odd-row",
  even_class: "even-row",
  headers: [],
  asc_sort: true
};

var buildRow = function(headerElements, rowCollection, rowElement) {
  var i,
      row = {};

  for (i = 0; i < headerElements.length; i+= 1) {
    if (headerElements[i].textContent) {
      row[headerElements[i].textContent] = rowCollection[i].textContent;
    }
  }
  row["row_elem"] = rowElement;
  return row;
};

var getTableHeaderNameList = function(elements) {
  var headerNames = [],
      i;

  for (i = 0; i < elements.length; i += 1) {
    headerNames.push(elements[i].textContent);
  }
  return headerNames;
};

var getTableHeaders = function() {
  return $("table.sortable-table th").get();
};

var setupTableFromElement = function(tableElement) {
  var headers,
      headersNames,
      rows,
      i;

  headers = getTableHeaders();
  headersNames = getTableHeaderNameList(headers);

  tableRowsAndData.headers = headersNames;
  tableRowsAndData.table = tableElement;

  rows = $("table.sortable-table tr").get().slice(1);

  for (i = 0; i < rows.length; i += 1) {
    tableRowsAndData.rows.push(buildRow(headers, rows[i].children, rows[i]));
  }

  console.log(tableRowsAndData.rows[0]["row_elem"]);
};

var compareHelper = function(val1, val2, numeric) {

  if (numeric) {
    if (tableRowsAndData.asc_sort) {
      return parseFloat(val1) <= parseFloat(val2);
    }

    return parseFloat(val1) >= parseFloat(val2);
  }

  if (tableRowsAndData.asc_sort) {
    return val1 <= val2;
  }

  return val1 >= val2;

};

var rewriteTableWith= function(newOrder) {
  var rows = $("table.sortable-table tr").get().slice(1),
      i,
      table = $("table.sortable-table").get()[0];

  for (i = rows.length-1; i >= 0; i -= 1) {
    rows[i].parentNode.removeChild(rows[i]);
  }

  for (i = 0; i < newOrder.length; i += 1) {
    table.appendChild(newOrder[i]["row_elem"]);
    if (i % 2 == 0) {
      newOrder[i]["row_elem"].className = tableRowsAndData.odd_class;
    }
    else {
      newOrder[i]["row_elem"].className = tableRowsAndData.even_class;
    }
  }
};

var sortByHeaderElement = function(headerElement, numeric=false) {
  var toSort = tableRowsAndData.rows,
      sortBy = headerElement.textContent,
      sorted,
      i,
      j;

  if (tableRowsAndData.headers.indexOf(sortBy) !== -1) {
    for (i = 0; i < toSort.length; i += 1) {
      if (i == 0) {
        sorted = [toSort[i]];
      }
      else {
        for (j = 0; j < sorted.length; j += 1) {
          if (compareHelper(sorted[j][sortBy], toSort[i][sortBy], numeric)) {
            sorted.splice(j, 0, toSort[i]);
            break;
          }
        }
        if (j == sorted.length) {
          sorted.push(toSort[i])
        }
      }
    }
  }

  tableRowsAndData.asc_sort = !tableRowsAndData.asc_sort;

  console.log(sorted);

  rewriteTableWith(sorted)
};
