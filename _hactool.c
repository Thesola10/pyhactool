#define PY_SSIZE_T_CLEAN 1
#include <Python.h>
#include <bytesobject.h>
#include <structmember.h>
#include "hactool/version.h"

#include "hactool/types.h"
#include "hactool/utils.h"
#include "hactool/settings.h"
#include "hactool/pki.h"
#include "hactool/nca.h"
#include "hactool/xci.h"
#include "hactool/nax0.h"
#include "hactool/extkeys.h"
#include "hactool/packages.h"
#include "hactool/nso.h"
#include "hactool/save.h"

static PyObject *HactoolError;
