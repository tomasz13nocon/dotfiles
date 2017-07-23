syn region cssInclude start=/@media\>/ end=/\ze$/ skipwhite skipnl contains=cssMediaProp,cssValueLength,cssMediaKeyword,cssValueInteger,cssMediaAttr,cssVendor,cssMediaType,cssIncludeKeyword,cssMediaComma,cssComment nextgroup=cssMediaBlock

