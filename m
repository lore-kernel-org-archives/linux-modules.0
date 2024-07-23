Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA6913C3F5
	for <linux-modules@vger.kernel.org>; Tue, 23 Jul 2024 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721761180; cv=none; b=Ca2BL1Rft1X83Rt8SZqZ0r3QcLIIOaOKUiScpW7feiFyhISr5+xMj3MdAyOWz9ACSRk3piBv83Eoekkl6ndLmlXjQv3w1VMSyG4CX35hqdpg143As/J8uasILcmw78csjnkbRM1aD5kXnO1SDxOkabPZzp0bx/LEHQGcFvk/Rqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721761180; c=relaxed/simple;
	bh=c0vxn9t/EYI7RtsAIOnQySW2g4N+Dgwx3DybhqV7VMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKJrzXeTiOhr9nf/naSGXEy4Ge5h7/pRBDRiOEKuQSd5jTkq0rY2PrUuLtEjE2EFrDaN4+xYyXdMO3okXxXjMbJ+PNUGr5O8AMIaMSzzVb4+7YTe+oDeQ9yyu01Tfa41OOI8O/LFyNHvKZDIq4FNGaqLVp3HcWSDycBUam6oROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFHOEFZ9; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFHOEFZ9"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79f0e7faafcso370046685a.3
        for <linux-modules@vger.kernel.org>; Tue, 23 Jul 2024 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721761175; x=1722365975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUsX2oqoqPhG3iSuhuD7GqQ3YqCIs0AbQ5TDNF0fsrY=;
        b=KFHOEFZ9bx53Sad1Cyhh6EprUu0Ol5Yt1cV2wEtCjy896/7ZYgSlYxT0ZP7PwhjRGv
         goQyZEIbWnYFjJtfJiehMyXummUxT5S9LSUfZDjMExxmxMZnurwjGaHmpuW48vGcstNY
         D3MVLcfXRD5exAfs/UGIhxYjePRS1z3Opk/UNWLjcjUYZnE3r4t5krHN3ac01WVwTKrL
         g0z1eJGxtT2Mpr1aH2hreX3BdkgfBZBvuEOpoPZAOsqt2AYEP7UWvU4jmav5HaC3lQ2i
         PgpAb/snqj2TniUkuFC7m4s3y0hARMsCV31QOJy9tfwJniCieIo2YA/szkh8zOnLPFst
         hrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721761175; x=1722365975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUsX2oqoqPhG3iSuhuD7GqQ3YqCIs0AbQ5TDNF0fsrY=;
        b=NWXhDJzilShhBc4vCeGfSVpRNzMqJldLRg7vdlsSGHnrIOFpJf3yqLSwDumUjbc7Id
         RaR2g7YhRedKzbFRKg9S3qABClTiSpChrTfcFBAg6gKJ29RsjYMUCsgJ6VgUQslbtTxQ
         zT/cpMdMnWmWOJqgKlefz2t/j6gROTdEWHoxFxurv2mus2NMeAeSrOhZm4RGXM3oiH9g
         08039wwO27OeUXObLTMsXzcL9mBxBCOms89RwaG+NqboiDj2JAsFrC0ZXF4qxgqUSdqF
         nQWm13DakORC4lkrMPBYMj18Nu/FI22wcFVfNB8ytJSAZag33SfNfYrjH+bpXe0WTdaf
         R7vw==
X-Gm-Message-State: AOJu0YyqQFzvDNtJbJDuTJUmht4S3Djrjc76R7IAY+OPvsg1yhr9pawH
	MSUz6iSgJEosO9WYCNX51VdVflVJaMuViWfw77nktu1ia3CyD2fu7SQdUQ==
X-Google-Smtp-Source: AGHT+IGL6O/rZ0RlZk83n0rdmolqm2WZwV/E6zV2rr4CA0l/VRkP0dJSP6GOPsrH3DoWj67gv18Ong==
X-Received: by 2002:a05:620a:2946:b0:79e:f75d:e8bf with SMTP id af79cd13be357-7a1ca12a541mr77153285a.42.1721761173695;
        Tue, 23 Jul 2024 11:59:33 -0700 (PDT)
Received: from ldmartin-desk2.lan ([134.134.137.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1990792a0sm504967685a.109.2024.07.23.11.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:59:32 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: emil.l.velikov@gmail.com,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH v2 1/3] Use SPDX header for license
Date: Tue, 23 Jul 2024 13:59:19 -0500
Message-ID: <20240723185921.1005569-2-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723185921.1005569-1-lucas.de.marchi@gmail.com>
References: <20240723185921.1005569-1-lucas.de.marchi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drop the lengthy license from each file and just use SPDX like most
projects nowadays. This doesn't have any change to license, just how
they are recorded in each file.

This follows the kernel approach: header files use '/*' for comments
while .c files use '//'.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 libkmod/libkmod-builtin.c     | 14 +-------------
 libkmod/libkmod-config.c      | 14 +-------------
 libkmod/libkmod-elf.c         | 14 +-------------
 libkmod/libkmod-file.c        | 14 +-------------
 libkmod/libkmod-index.c       | 14 +-------------
 libkmod/libkmod-index.h       | 14 +-------------
 libkmod/libkmod-list.c        | 14 +-------------
 libkmod/libkmod-module.c      | 14 +-------------
 libkmod/libkmod-signature.c   | 14 +-------------
 libkmod/libkmod.c             | 14 +-------------
 libkmod/libkmod.h             | 14 +-------------
 m4/attributes.m4              | 17 ++---------------
 m4/features.m4                | 17 +++--------------
 shared/array.c                | 14 +-------------
 shared/hash.c                 | 14 +-------------
 shared/macro.h                | 14 +-------------
 shared/scratchbuf.c           | 14 +-------------
 shared/strbuf.c               | 14 +-------------
 shared/util.c                 | 14 +-------------
 shell-completion/bash/kmod    | 14 +-------------
 testsuite/delete_module.c     | 14 +-------------
 testsuite/init_module.c       | 14 +-------------
 testsuite/path.c              | 14 +-------------
 testsuite/test-array.c        | 14 +-------------
 testsuite/test-blacklist.c    | 14 +-------------
 testsuite/test-dependencies.c | 14 +-------------
 testsuite/test-depmod.c       | 14 +-------------
 testsuite/test-hash.c         | 14 +-------------
 testsuite/test-init.c         | 14 +-------------
 testsuite/test-initstate.c    | 14 +-------------
 testsuite/test-list.c         | 14 +-------------
 testsuite/test-loaded.c       | 14 +-------------
 testsuite/test-modinfo.c      | 14 +-------------
 testsuite/test-modprobe.c     | 14 +-------------
 testsuite/test-new-module.c   | 14 +-------------
 testsuite/test-scratchbuf.c   | 14 +-------------
 testsuite/test-strbuf.c       | 14 +-------------
 testsuite/test-testsuite.c    | 14 +-------------
 testsuite/test-user.c         | 14 +-------------
 testsuite/test-util.c         | 14 +-------------
 testsuite/testsuite.c         | 14 +-------------
 testsuite/testsuite.h         | 14 +-------------
 testsuite/uname.c             | 14 +-------------
 tools/depmod.c                | 14 +-------------
 tools/insmod.c                | 14 +-------------
 tools/kmod.c                  | 14 +-------------
 tools/kmod.h                  | 14 +-------------
 tools/log.c                   | 14 +-------------
 tools/log.h                   | 14 +-------------
 tools/lsmod.c                 | 14 +-------------
 tools/modinfo.c               | 14 +-------------
 tools/modprobe.c              | 14 +-------------
 tools/rmmod.c                 | 14 +-------------
 tools/static-nodes.c          | 14 +-------------
 54 files changed, 57 insertions(+), 705 deletions(-)

diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
index 65334a8..66f9469 100644
--- a/libkmod/libkmod-builtin.c
+++ b/libkmod/libkmod-builtin.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * libkmod - interface to kernel built-in modules
  *
  * Copyright (C) 2019  Alexey Gladkov <gladkov.alexey@gmail.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <sys/types.h>
diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index fb28ed9..af9b93e 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -1,21 +1,9 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * libkmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  * Copyright (C) 2013  Intel Corporation. All rights reserved.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <ctype.h>
diff --git a/libkmod/libkmod-elf.c b/libkmod/libkmod-elf.c
index 933825b..93bf66c 100644
--- a/libkmod/libkmod-elf.c
+++ b/libkmod/libkmod-elf.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * libkmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <assert.h>
diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index 52490fb..b39c32d 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * libkmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/libkmod/libkmod-index.c b/libkmod/libkmod-index.c
index 6a34c8d..b6245f2 100644
--- a/libkmod/libkmod-index.c
+++ b/libkmod/libkmod-index.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * libkmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <arpa/inet.h>
diff --git a/libkmod/libkmod-index.h b/libkmod/libkmod-index.h
index db671b0..850b506 100644
--- a/libkmod/libkmod-index.h
+++ b/libkmod/libkmod-index.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  * libkmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #pragma once
diff --git a/libkmod/libkmod-list.c b/libkmod/libkmod-list.c
index 7623693..ad07587 100644
--- a/libkmod/libkmod-list.c
+++ b/libkmod/libkmod-list.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * libkmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <stdlib.h>
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 5c26e03..b08393f 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * libkmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <assert.h>
diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index 80f6447..7e3b973 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * libkmod - module signature display
  *
  * Copyright (C) 2013 Michal Marek, SUSE
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <endian.h>
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index fecb8e7..7704cac 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * libkmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <assert.h>
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index fce66d1..b6273a0 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  * libkmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #pragma once
diff --git a/m4/attributes.m4 b/m4/attributes.m4
index bfdb50f..208dfdc 100644
--- a/m4/attributes.m4
+++ b/m4/attributes.m4
@@ -1,23 +1,10 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl
 dnl Macros to check the presence of generic (non-typed) symbols.
 dnl Copyright (c) 2006-2008 Diego Pettenò <flameeyes@gmail.com>
 dnl Copyright (c) 2006-2008 xine project
 dnl Copyright (c) 2012 Lucas De Marchi <lucas.de.marchi@gmail.com>
 dnl
-dnl This program is free software; you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2, or (at your option)
-dnl any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-dnl GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program; if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-dnl 02110-1301, USA.
-dnl
 dnl As a special exception, the copyright owners of the
 dnl macro gives unlimited permission to copy, distribute and modify the
 dnl configure scripts that are the output of Autoconf when processing the
diff --git a/m4/features.m4 b/m4/features.m4
index 82a244f..6a9b5bd 100644
--- a/m4/features.m4
+++ b/m4/features.m4
@@ -1,17 +1,6 @@
-#  Copyright (c) 2015 Lucas De Marchi <lucas.de.marchi@gmail.com>
-#
-#  This program is free software: you can redistribute it and/or modify it
-#  under the terms of the GNU General Public License as published by the
-#  Free Software Foundation, either version 2 of the License, or (at your
-#  option) any later version.
-#
-#  This program is distributed in the hope that it will be useful, but
-#  WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
-#  Public License for more details.
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
-#  You should have received a copy of the GNU General Public License along
-#  with this program. If not, see <http://www.gnu.org/licenses/>.
+#  Copyright (c) 2015 Lucas De Marchi <lucas.de.marchi@gmail.com>
 #
 #  As a special exception, the respective Autoconf Macro's copyright owner
 #  gives unlimited permission to copy, distribute and modify the configure
@@ -25,7 +14,7 @@
 #  Macro released by the Autoconf Archive. When you make and distribute a
 #  modified version of the Autoconf Macro, you may extend this special
 #  exception to the GPL to apply to your modified version as well.
-#
+
 # CC_FEATURE_APPEND([FLAGS], [ENV-TO-CHECK], [FLAG-NAME])
 AC_DEFUN([CC_FEATURE_APPEND], [
   AS_VAR_PUSHDEF([FLAGS], [$1])dnl
diff --git a/shared/array.c b/shared/array.c
index c2e2e14..128c9fc 100644
--- a/shared/array.c
+++ b/shared/array.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * libkmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <assert.h>
diff --git a/shared/hash.c b/shared/hash.c
index a87bc50..9eb87d8 100644
--- a/shared/hash.c
+++ b/shared/hash.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * libkmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/shared/macro.h b/shared/macro.h
index b59f7dc..e8a890a 100644
--- a/shared/macro.h
+++ b/shared/macro.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  * kmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #pragma once
 
diff --git a/shared/scratchbuf.c b/shared/scratchbuf.c
index 8d9eb83..e995755 100644
--- a/shared/scratchbuf.c
+++ b/shared/scratchbuf.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * kmod - interface to kernel module operations
  *
  * Copyright (C) 2016  Intel Corporation. All rights reserved.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "scratchbuf.h"
 
diff --git a/shared/strbuf.c b/shared/strbuf.c
index a69d914..9a8ebea 100644
--- a/shared/strbuf.c
+++ b/shared/strbuf.c
@@ -1,21 +1,9 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * libkmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  * Copyright (C) 2014  Intel Corporation. All rights reserved.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <assert.h>
diff --git a/shared/util.c b/shared/util.c
index 437bc69..5c1afb9 100644
--- a/shared/util.c
+++ b/shared/util.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * kmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  * Copyright (C) 2012  Lucas De Marchi <lucas.de.marchi@gmail.com>
  * Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <assert.h>
diff --git a/shell-completion/bash/kmod b/shell-completion/bash/kmod
index f530836..6c66dc3 100644
--- a/shell-completion/bash/kmod
+++ b/shell-completion/bash/kmod
@@ -1,22 +1,10 @@
 # kmod completion                                          -*- shell-script -*-
+# SPDX-License-Identifier: LGPL-2.1-or-later
 #
 # This file is part of kmod.
 #
 # Copyright 2010 Ran Benita
 # Copyright (C) 2013  Intel Corporation. All rights reserved.
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of the GNU Lesser General Public License as published by
-# the Free Software Foundation; either version 2.1 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 __contains_word () {
         local word=$1; shift
diff --git a/testsuite/delete_module.c b/testsuite/delete_module.c
index f3ae20b..8df93a1 100644
--- a/testsuite/delete_module.c
+++ b/testsuite/delete_module.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2012-2013  ProFUSION embedded systems
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <assert.h>
diff --git a/testsuite/init_module.c b/testsuite/init_module.c
index 503e703..d842ace 100644
--- a/testsuite/init_module.c
+++ b/testsuite/init_module.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2012-2013  ProFUSION embedded systems
  * Copyright (C) 2012-2013  Lucas De Marchi <lucas.de.marchi@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef HAVE_FINIT_MODULE
diff --git a/testsuite/path.c b/testsuite/path.c
index 00935fb..7c5fa6c 100644
--- a/testsuite/path.c
+++ b/testsuite/path.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2012-2013  ProFUSION embedded systems
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /* We unset _FILE_OFFSET_BITS here so we can override both stat and stat64 on
diff --git a/testsuite/test-array.c b/testsuite/test-array.c
index ef1e1e9..61350f8 100644
--- a/testsuite/test-array.c
+++ b/testsuite/test-array.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C)  2014 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testsuite/test-blacklist.c b/testsuite/test-blacklist.c
index 969567d..64dc58e 100644
--- a/testsuite/test-blacklist.c
+++ b/testsuite/test-blacklist.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testsuite/test-dependencies.c b/testsuite/test-dependencies.c
index 38f5fc1..5358f7c 100644
--- a/testsuite/test-dependencies.c
+++ b/testsuite/test-dependencies.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index eaa5b1a..d5aba23 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2012-2013  ProFUSION embedded systems
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testsuite/test-hash.c b/testsuite/test-hash.c
index 1bea04e..1932102 100644
--- a/testsuite/test-hash.c
+++ b/testsuite/test-hash.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C)  2014 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testsuite/test-init.c b/testsuite/test-init.c
index edbfc23..11fd8b8 100644
--- a/testsuite/test-init.c
+++ b/testsuite/test-init.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2012-2013  ProFUSION embedded systems
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testsuite/test-initstate.c b/testsuite/test-initstate.c
index 9332e8f..455dbee 100644
--- a/testsuite/test-initstate.c
+++ b/testsuite/test-initstate.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2015  Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testsuite/test-list.c b/testsuite/test-list.c
index 535e8d7..6872975 100644
--- a/testsuite/test-list.c
+++ b/testsuite/test-list.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C)  2015 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <stdio.h>
diff --git a/testsuite/test-loaded.c b/testsuite/test-loaded.c
index 9d5814f..9bf8eb7 100644
--- a/testsuite/test-loaded.c
+++ b/testsuite/test-loaded.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2012-2013  ProFUSION embedded systems
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testsuite/test-modinfo.c b/testsuite/test-modinfo.c
index 373dc95..2157a11 100644
--- a/testsuite/test-modinfo.c
+++ b/testsuite/test-modinfo.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2012-2013  ProFUSION embedded systems
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index 6a824c9..534503d 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2012-2013  ProFUSION embedded systems
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testsuite/test-new-module.c b/testsuite/test-new-module.c
index 9872b78..7ce8503 100644
--- a/testsuite/test-new-module.c
+++ b/testsuite/test-new-module.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2012-2013  ProFUSION embedded systems
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testsuite/test-scratchbuf.c b/testsuite/test-scratchbuf.c
index 6d86957..69ad645 100644
--- a/testsuite/test-scratchbuf.c
+++ b/testsuite/test-scratchbuf.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C)  2016 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testsuite/test-strbuf.c b/testsuite/test-strbuf.c
index c98c91d..db80c53 100644
--- a/testsuite/test-strbuf.c
+++ b/testsuite/test-strbuf.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C)  2014 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testsuite/test-testsuite.c b/testsuite/test-testsuite.c
index c77c4bb..42c88e2 100644
--- a/testsuite/test-testsuite.c
+++ b/testsuite/test-testsuite.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2012-2013  ProFUSION embedded systems
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <dirent.h>
diff --git a/testsuite/test-user.c b/testsuite/test-user.c
index c37c9a0..97a4747 100644
--- a/testsuite/test-user.c
+++ b/testsuite/test-user.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright Red Hat
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testsuite/test-util.c b/testsuite/test-util.c
index e3243e8..3511245 100644
--- a/testsuite/test-util.c
+++ b/testsuite/test-util.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2012-2013  ProFUSION embedded systems
  * Copyright (C) 2012  Pedro Pedruzzi
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <fcntl.h>
diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
index 6602aaf..a567839 100644
--- a/testsuite/testsuite.c
+++ b/testsuite/testsuite.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2012-2013  ProFUSION embedded systems
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <dirent.h>
diff --git a/testsuite/testsuite.h b/testsuite/testsuite.h
index 4b2565c..0b7b867 100644
--- a/testsuite/testsuite.h
+++ b/testsuite/testsuite.h
@@ -1,18 +1,6 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  * Copyright (C) 2012-2013  ProFUSION embedded systems
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #pragma once
diff --git a/testsuite/uname.c b/testsuite/uname.c
index 27f92d5..a7bd962 100644
--- a/testsuite/uname.c
+++ b/testsuite/uname.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  * Copyright (C) 2012-2013  ProFUSION embedded systems
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <dlfcn.h>
diff --git a/tools/depmod.c b/tools/depmod.c
index 8e9e2d1..8113721 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * kmod-depmod - calculate modules.dep  using libkmod.
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <assert.h>
diff --git a/tools/insmod.c b/tools/insmod.c
index c422971..7c3ed04 100644
--- a/tools/insmod.c
+++ b/tools/insmod.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * kmod-insmod - insert modules into linux kernel using libkmod.
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/tools/kmod.c b/tools/kmod.c
index e1a73be..989d343 100644
--- a/tools/kmod.c
+++ b/tools/kmod.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * kmod - one tool to rule them all
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/tools/kmod.h b/tools/kmod.h
index 1770786..f4d5e13 100644
--- a/tools/kmod.h
+++ b/tools/kmod.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * kmod - one tool to rule them all
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #pragma once
diff --git a/tools/log.c b/tools/log.c
index 3317a35..050ecb2 100644
--- a/tools/log.c
+++ b/tools/log.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * kmod - log infrastructure
  *
  * Copyright (C) 2012-2013  ProFUSION embedded systems
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/tools/log.h b/tools/log.h
index d55a4c6..20d39a1 100644
--- a/tools/log.h
+++ b/tools/log.h
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * kmod - log infrastructure
  *
  * Copyright (C) 2012-2013  ProFUSION embedded systems
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <stdarg.h>
diff --git a/tools/lsmod.c b/tools/lsmod.c
index d9a27f2..2c2e62a 100644
--- a/tools/lsmod.c
+++ b/tools/lsmod.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * kmod-lsmod - list modules from linux kernel using libkmod.
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/tools/modinfo.c b/tools/modinfo.c
index cacc32d..31ffa99 100644
--- a/tools/modinfo.c
+++ b/tools/modinfo.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * kmod-modinfo - query kernel module information using libkmod.
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/tools/modprobe.c b/tools/modprobe.c
index 4328da6..47b721d 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * kmod-modprobe - manage linux kernel modules using libkmod.
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <assert.h>
diff --git a/tools/rmmod.c b/tools/rmmod.c
index 3942e7b..0f28ce2 100644
--- a/tools/rmmod.c
+++ b/tools/rmmod.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * kmod-rmmod - remove modules from linux kernel using libkmod.
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/tools/static-nodes.c b/tools/static-nodes.c
index 5ef3743..435e0dc 100644
--- a/tools/static-nodes.c
+++ b/tools/static-nodes.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * kmod-static-nodes - manage modules.devname
  *
  * Copyright (C) 2004-2012 Kay Sievers <kay@vrfy.org>
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  * Copyright (C) 2013 Tom Gundersen <teg@jklm.no>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
-- 
2.45.2

