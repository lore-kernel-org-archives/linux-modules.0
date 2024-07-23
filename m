Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1E13D896
	for <linux-modules@vger.kernel.org>; Tue, 23 Jul 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721761179; cv=none; b=IhINH7kgwxoj+FmGK05DFL33E8FQ3v7686EjB4wBLu4JByH5SDWCPtpkEvb/UNdMtoSkljLLEVdhzFHivkfFQHKQkxvAOdXg+L4LXOR6a4bbZ3W+HsckY2Q5rxU6Hn1LJS9lMFISrSpehRYt5Da5ACl4GNV8y+ef4/pIVQSogLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721761179; c=relaxed/simple;
	bh=haA7qcaP3WvAXpXx/Le+cpBPXqGjlQU427btO1EMtJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fb2ikiJ47YDph+E46XOBE3qr43GitwRnNmjftKbKBLqDx+mUyuDPe3zt20flsJqpUQEF34O4KSJ2PU1iqa2ePX0WcaMQ2tUN5BH/IbLIzbCooBRucdh+OdDwqsy0OnG9uug+9U11XHSJD0Tb/MgA52Xkn9rUvPWtp9p8R6SvmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZuc5KV6; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZuc5KV6"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79ef93865afso335625585a.1
        for <linux-modules@vger.kernel.org>; Tue, 23 Jul 2024 11:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721761176; x=1722365976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLGyGmw4I9bEwlKV7jHpqoR0Q29zndOl10V2bhJvcAs=;
        b=CZuc5KV6VbqvoXUJuODBjZxgx9vM0EltqaYy6TCA+H+Z0kRZ3IGE6YhygpoPztRUE+
         sB7Hf8I9r2QKvG8OkmSrhmRiS1owww5gvciKZGGwMq68O08bs2llquHwrkTe0dxnd7Tj
         SnZ4Dt46yvBhVYlPrpcmzgCtD27aYe5ZnJJWk7YPqSNA8jut4/0n07ZAIX4DsGrbvZ/0
         BqT0HB0SkpJAZzTG9ITeCJIKH2CCLJOshlTVZxSqDipj0e7dIJ/T0K7WYDQ6ID652Meg
         VZZKmp3wmWJVqO5TocXxfk8SOCT5Md7ahn+5nR8DH2F26AAUxnOCEwKtwsdh9p4VXvQ6
         wrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721761176; x=1722365976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLGyGmw4I9bEwlKV7jHpqoR0Q29zndOl10V2bhJvcAs=;
        b=Q3UcL4AW3QhRxmGYtaL4QHaZLOzw3+LHzg64tM2asP/M1S+c0NZj3NHLn6CQut0UYz
         9DDJNnSdWjg0O1pMEoZ3JigqEWqem+PH5T/eSAXFbzRd3Fx+31NSCWWIJhEgh08eXnmi
         1TbIfwB3hCSFgi27IJnEsv+HIajoPMXfCz6KhS8upiN8D6KXssAJbLGukwepI9EDEf+p
         aFmTjHP7VTr0OINbROsbDp8H/yT3svuCCVTIPP/eLn2Z0zxNVcLljMjVUbnxJPKwwiUG
         DThzA0s5lKPp7FhUQFKviSitCAuqrAV+aMnpfX8HwjqjJzYPthn76J94sv99SJTF7o89
         iWLg==
X-Gm-Message-State: AOJu0YxBc5Snd3n/R6y+fzsxfKv4YSmTXFr/Ds8tMG5Pw78KjQbYTroh
	kRxRmEQ8FlbaT78I8wKZwXG/+7AwFOdM7N3ONEQsFSKeHPeWLWQ/tzIo9Q==
X-Google-Smtp-Source: AGHT+IHYcBvXLdFJDxHe3KP2LAbUN83r1xmdma7AmGldVHcOXmZ/prcFynIjZZIigIEn/Z2YIjf3YA==
X-Received: by 2002:a05:620a:2585:b0:79d:67f3:636d with SMTP id af79cd13be357-7a1a652ef02mr1172431585a.19.1721761175617;
        Tue, 23 Jul 2024 11:59:35 -0700 (PDT)
Received: from ldmartin-desk2.lan ([134.134.137.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1990792a0sm504967685a.109.2024.07.23.11.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:59:35 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: emil.l.velikov@gmail.com,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH v2 2/3] Drop the one line short description on sources
Date: Tue, 23 Jul 2024 13:59:20 -0500
Message-ID: <20240723185921.1005569-3-lucas.de.marchi@gmail.com>
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

Some are outdated, misleading or just repeat the same thing over and
over. Remove them as they are not needed.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 libkmod/libkmod-builtin.c   | 2 --
 libkmod/libkmod-config.c    | 2 --
 libkmod/libkmod-elf.c       | 2 --
 libkmod/libkmod-file.c      | 2 --
 libkmod/libkmod-index.c     | 2 --
 libkmod/libkmod-index.h     | 2 --
 libkmod/libkmod-list.c      | 2 --
 libkmod/libkmod-module.c    | 2 --
 libkmod/libkmod-signature.c | 2 --
 libkmod/libkmod.c           | 2 --
 libkmod/libkmod.h           | 2 --
 m4/attributes.m4            | 1 -
 shared/array.c              | 2 --
 shared/hash.c               | 2 --
 shared/macro.h              | 2 --
 shared/scratchbuf.c         | 2 --
 shared/strbuf.c             | 2 --
 shared/util.c               | 2 --
 shell-completion/bash/kmod  | 2 --
 tools/depmod.c              | 2 --
 tools/insmod.c              | 2 --
 tools/kmod.c                | 2 --
 tools/kmod.h                | 2 --
 tools/log.c                 | 2 --
 tools/log.h                 | 2 --
 tools/lsmod.c               | 2 --
 26 files changed, 51 deletions(-)

diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
index 66f9469..fd0f549 100644
--- a/libkmod/libkmod-builtin.c
+++ b/libkmod/libkmod-builtin.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel built-in modules
- *
  * Copyright (C) 2019  Alexey Gladkov <gladkov.alexey@gmail.com>
  */
 
diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index af9b93e..919f4ed 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  * Copyright (C) 2013  Intel Corporation. All rights reserved.
  */
diff --git a/libkmod/libkmod-elf.c b/libkmod/libkmod-elf.c
index 93bf66c..06a9876 100644
--- a/libkmod/libkmod-elf.c
+++ b/libkmod/libkmod-elf.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index b39c32d..c6c1e22 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
diff --git a/libkmod/libkmod-index.c b/libkmod/libkmod-index.c
index b6245f2..b7f8bd3 100644
--- a/libkmod/libkmod-index.c
+++ b/libkmod/libkmod-index.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
diff --git a/libkmod/libkmod-index.h b/libkmod/libkmod-index.h
index 850b506..5f0657e 100644
--- a/libkmod/libkmod-index.h
+++ b/libkmod/libkmod-index.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
- * libkmod - interface to kernel module operations
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
diff --git a/libkmod/libkmod-list.c b/libkmod/libkmod-list.c
index ad07587..38a3c27 100644
--- a/libkmod/libkmod-list.c
+++ b/libkmod/libkmod-list.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index b08393f..c095e63 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index 7e3b973..48caf74 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - module signature display
- *
  * Copyright (C) 2013 Michal Marek, SUSE
  */
 
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 7704cac..7953716 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index b6273a0..f3376f5 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
- * libkmod - interface to kernel module operations
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
diff --git a/m4/attributes.m4 b/m4/attributes.m4
index 208dfdc..63aca0a 100644
--- a/m4/attributes.m4
+++ b/m4/attributes.m4
@@ -1,6 +1,5 @@
 dnl SPDX-License-Identifier: GPL-2.0-or-later
 dnl
-dnl Macros to check the presence of generic (non-typed) symbols.
 dnl Copyright (c) 2006-2008 Diego Pettenò <flameeyes@gmail.com>
 dnl Copyright (c) 2006-2008 xine project
 dnl Copyright (c) 2012 Lucas De Marchi <lucas.de.marchi@gmail.com>
diff --git a/shared/array.c b/shared/array.c
index 128c9fc..f63ca50 100644
--- a/shared/array.c
+++ b/shared/array.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
diff --git a/shared/hash.c b/shared/hash.c
index 9eb87d8..37a8396 100644
--- a/shared/hash.c
+++ b/shared/hash.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
diff --git a/shared/macro.h b/shared/macro.h
index e8a890a..d70c0b7 100644
--- a/shared/macro.h
+++ b/shared/macro.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
- * kmod - interface to kernel module operations
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 #pragma once
diff --git a/shared/scratchbuf.c b/shared/scratchbuf.c
index e995755..5c51e4b 100644
--- a/shared/scratchbuf.c
+++ b/shared/scratchbuf.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod - interface to kernel module operations
- *
  * Copyright (C) 2016  Intel Corporation. All rights reserved.
  */
 #include "scratchbuf.h"
diff --git a/shared/strbuf.c b/shared/strbuf.c
index 9a8ebea..0b63166 100644
--- a/shared/strbuf.c
+++ b/shared/strbuf.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  * Copyright (C) 2014  Intel Corporation. All rights reserved.
  */
diff --git a/shared/util.c b/shared/util.c
index 5c1afb9..66a7622 100644
--- a/shared/util.c
+++ b/shared/util.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod - interface to kernel module operations
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  * Copyright (C) 2012  Lucas De Marchi <lucas.de.marchi@gmail.com>
  * Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
diff --git a/shell-completion/bash/kmod b/shell-completion/bash/kmod
index 6c66dc3..7dd3d33 100644
--- a/shell-completion/bash/kmod
+++ b/shell-completion/bash/kmod
@@ -1,8 +1,6 @@
 # kmod completion                                          -*- shell-script -*-
 # SPDX-License-Identifier: LGPL-2.1-or-later
 #
-# This file is part of kmod.
-#
 # Copyright 2010 Ran Benita
 # Copyright (C) 2013  Intel Corporation. All rights reserved.
 
diff --git a/tools/depmod.c b/tools/depmod.c
index 8113721..661cfc4 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * kmod-depmod - calculate modules.dep  using libkmod.
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
diff --git a/tools/insmod.c b/tools/insmod.c
index 7c3ed04..4a1d11d 100644
--- a/tools/insmod.c
+++ b/tools/insmod.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * kmod-insmod - insert modules into linux kernel using libkmod.
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
diff --git a/tools/kmod.c b/tools/kmod.c
index 989d343..d28ec7b 100644
--- a/tools/kmod.c
+++ b/tools/kmod.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * kmod - one tool to rule them all
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
diff --git a/tools/kmod.h b/tools/kmod.h
index f4d5e13..c3c8683 100644
--- a/tools/kmod.h
+++ b/tools/kmod.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * kmod - one tool to rule them all
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
diff --git a/tools/log.c b/tools/log.c
index 050ecb2..e2fe9a7 100644
--- a/tools/log.c
+++ b/tools/log.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * kmod - log infrastructure
- *
  * Copyright (C) 2012-2013  ProFUSION embedded systems
  */
 
diff --git a/tools/log.h b/tools/log.h
index 20d39a1..72836be 100644
--- a/tools/log.h
+++ b/tools/log.h
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * kmod - log infrastructure
- *
  * Copyright (C) 2012-2013  ProFUSION embedded systems
  */
 
diff --git a/tools/lsmod.c b/tools/lsmod.c
index 2c2e62a..323aad6 100644
--- a/tools/lsmod.c
+++ b/tools/lsmod.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * kmod-lsmod - list modules from linux kernel using libkmod.
- *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
-- 
2.45.2

