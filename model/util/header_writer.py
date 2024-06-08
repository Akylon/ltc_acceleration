'''
Author: Sandro Pedrett
History:
    - creation and written by Sandro Pedrett
    - 4.4.24 adjusted to ltc project by Yanik Kuster
'''

import numpy as np
import re

from collections.abc import Iterable


def macrocase(value):
    """
    Convert a string to MACRO_CASE
    """
    return re.sub("[{}]+".format(re.escape(" -_")), "_", value).upper()


class HLSHeaderWriter:
    """
    HLS C++ Header writer. Used to generate .h files
    """

    DEFAULT_INDENT = "    "

    def __init__(self, file_stream):
        self.__file_stream = file_stream
        self.__indent_level = 0

    def write_typedef(self, type, name):
        self.__write_line(f"typedef {type} {name};", new_line=True)

    def write_constant(self, name, type, values):
        """
        Depending on type of value pass parameter to a fitting writer
        """
        if isinstance(values, Iterable):
            values = np.asarray(values)
            self.__write_const_array(name, type, values)

        else:
            self.__write_constant_scalar(name, type=type, value=values)

    def write_buffer(self, name, type, values):
        self.__write_buffer(name, type, values)

    def __write_constant_scalar(self, name, type="size_t", value=0):
        """
        Write a constant
        """
        self.__write_line(f"static const {type} {name} = {value};", new_line=True)

    def __write_const_array(self, name, type, values):
        """
        Write a constant array
        """
        dims = values.ndim
        brackets = f"[{np.prod(values.shape)}]"

        self.__write_line(f"static const {type} {name}{brackets} = ", new_line=False)
        self.__write_array_values(values)
        self.__write_line(";")

    def __write_buffer(self, name, type, values):
        """
        Write a array
        """
        dims = values.ndim
        brackets = f"[{np.prod(values.shape)}]"

        self.__write_line(f"static {type} {name}{brackets} = ", new_line=False)
        self.__write_array_values(values)
        self.__write_line(";")

    def __write_array_values(self, array, level=0):
        if array.ndim > 1:
            self.__write_line("{")
            self.indent()

            for col in array:
                self.__write_array_values(col, level=level + 1)

            self.unindent()
            self.__write_line(f"}}{',' if level > 0 else ''}", new_line=level > 0)

        else:
            if level == 0:  # only write { for ndim = 1.
                self.__write_line("{ ", new_line=False)
            self.__write_line(", ".join([str(x) for x in array]), new_line=False, indent=False)

            if level > 0:
                self.__write_line(" ,", indent=False)  # if closing bracket required use " }," instead
            else:
                self.__write_line(" }", new_line=False, indent=False)

    def write_block_comment(self, comments):
        """
        Write a c++ comment block.
        :param comments: can be a string for single line, or a list for multiline comment
        """
        # convert to list
        if not isinstance(comments, Iterable):
            comments = [comments]
        elif isinstance(comments, str):
            comments = [comments]

        self.__write_line("//")
        for comment in comments:
            self.__write_line(f"// {comment}")
        self.__write_line("//")

    def write_preprocessor(self, define):
        """
        write a pre-processor statement
        """
        self.__write_line(f"#{define}")

    def indent(self):
        """
        Indent increment
        """
        self.__indent_level = 1 + self.__indent_level

    def unindent(self):
        """
        Indent decrement
        """
        self.__indent_level = max(0, self.__indent_level - 1)

    def write_new_line(self):
        """
        Writes a new line
        """
        self.__write_line()

    def __write_line(self, line="", new_line=True, indent=True):
        """
        Write given line with expected indent to file
        """
        if indent:
            self.__file_stream.write(self.DEFAULT_INDENT * self.__indent_level)

        self.__file_stream.write(f"{line}")

        if new_line:
            self.__file_stream.write("\n")
