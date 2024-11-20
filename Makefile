#
# Copyright (C) 2022 Xiaomi Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include $(APPDIR)/Make.defs

CSRCS     = lib/libexfat.c
CFLAGS   += -D__le16=uint16_t
CFLAGS   += -D__le32='unsigned int'
CFLAGS   += -D__le64=uint64_t
CFLAGS   += -D__u8=uint8_t
CFLAGS   += -D__u16=uint16_t
CFLAGS   += -D__u32='unsigned int'
CFLAGS   += ${shell $(INCDIR) $(INCDIROPT) "$(CC)" .}
CFLAGS   += ${shell $(INCDIR) $(INCDIROPT) "$(CC)" include/}
PRIORITY  = $(CONFIG_LIB_EXFATPROGS_PRIORITY)
STACKSIZE = $(CONFIG_LIB_EXFATPROGS_STACKSIZE)
MODULE    = $(CONFIG_LIB_EXFATPROGS)

ifneq ($(CONFIG_LIB_EXFATPROGS_DUMP),)
MAINSRC  += dump/dump.c
PROGNAME += dumpexfat
endif

ifneq ($(CONFIG_LIB_EXFATPROGS_LABEL),)
MAINSRC  += label/label.c
PROGNAME += labelexfat
endif

ifneq ($(CONFIG_LIB_EXFATPROGS_TUNE),)
MAINSRC  += tune/tune.c
PROGNAME += tuneexfat
endif

ifneq ($(CONFIG_LIB_EXFATPROGS_FSCK),)
CFLAGS   += ${shell $(INCDIR) $(INCDIROPT) "$(CC)" fsck/}
CSRCS    += fsck/repair.c fsck/de_iter.c
MAINSRC  += fsck/fsck.c
PROGNAME += fsckexfat
endif

ifneq ($(CONFIG_LIB_EXFATPROGS_MKFS),)
CFLAGS   += ${shell $(INCDIR) $(INCDIROPT) "$(CC)" mkfs/}
CSRCS    += mkfs/upcase.c
MAINSRC  += mkfs/mkfs.c
PROGNAME += mkfsexfat
endif


include $(APPDIR)/Application.mk
