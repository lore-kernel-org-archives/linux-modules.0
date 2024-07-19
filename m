Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B62F34
	for <linux-modules@vger.kernel.org>; Fri, 19 Jul 2024 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721427195; cv=none; b=f1osh2gFXbBg4XDNMG66oDVmiCBPLFHbA2jxke4Kc/aWQ0M85zBNNTt2MPUL56dXAyz2Vy7RP0MEVi2G0WnMPQtfvm9KRjO4cZHqOJaJ4kUUYnQLKr/+afctOurk25gVpDK6L7gCq6Yw1jk6IR3mx33aWObeLef5cgrdBWg/Mck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721427195; c=relaxed/simple;
	bh=HEgkU/PUMuGyv0/nBU58V+L4DjCcBtk2ZCj9NbQnj7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p76mZL3OBS33G/BPg8RoNns1kOrISCpJ32pvy34fEKBlSrEHWOdFiNMqwXB//V/vG00FKTpNYFs4thG2p8Q+cg0iWx0UsBPgl/JR2AtCiJ786dw1n89fEFKgBtWMidpCe9PuxKRQHgrL7/xBULEWj9FXgkRYHWfZ2MQQKJQgi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By9ZmfC+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By9ZmfC+"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79f323f0898so111770885a.0
        for <linux-modules@vger.kernel.org>; Fri, 19 Jul 2024 15:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721427190; x=1722031990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zfIZQB1okgrN/5p6ySv5mLOnx9G2ApVgpt0cSJRUB0Y=;
        b=By9ZmfC+U2YpCTApCTwyMONm1ApbaPGK9vEq14gfRJVImG3aOyTDarkvJQRkJl6u55
         hQHXBDyOBTLQgoRvvBnMvwQXbM7RAmglOS0yL6o4ooWUweDg+HTdrpIuN2bQQJs3Msab
         P2hyvXHBrNLabvPX1nzqY55IT8WxKD/qt7cMv/wrmHZM92Xi5r9JsrzwTbc0YD+RQ8Dy
         wHd5jSYX6i5Xb2wI6096ADWkQvqz1WWEY4wQcCMBa71vPk9NC+VdP7KtUkfSLXlaooV9
         YJVwgnXe3rKGTpKHLrzssWu/CGtRbRZELpOWjdZQiAjWfriayIqXkJRMQXfmV2kCiHzg
         3I2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721427190; x=1722031990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfIZQB1okgrN/5p6ySv5mLOnx9G2ApVgpt0cSJRUB0Y=;
        b=RZb5gRH+/xYAUbTfZFCym7Qohm8ktRYC6lJ3HX/5XJZE1+jTVIBPMBASlC0C5L1j1g
         BWD/3mXzw0AF6l/gmf7Y8pG1H+vfLoEll3+npjZlyL1EaTRlkTVZ5Ni1+f8QNTh5/rY6
         xI6Mmu0gmwmAr6rCy45vsEmuSPJwPZKtwx2qNyOZQ+OK8GhMtHulfVGhyLI9/PA1hy5K
         X+lioPAERvz/o/c7QY9wbwRfPJJzS+s8AziXpoHi6CqA40r+DfmSK/YLWwHVbkvuBDgW
         p4DPNN3qhjHlu+OCiH12bOKUbdtVHQQPmmuaMd9oSZqbZDG+itE6fV1vjSFa/n30Ml6H
         aLvw==
X-Gm-Message-State: AOJu0YxdoAtaiELAhVpflCjSVH4YzqneSTcgPsLJr4Y6gS93Yon3Df0Y
	nyMTF7rfcs0C7a+gyJ4SHStO/Z3yLHuJ+EAjtpO9vP7SJpxWyajp7UPgIg==
X-Google-Smtp-Source: AGHT+IEOSTlaQYu1TLlHzZwCZiXG1TPHaoxSN/ovpSfc4SvpzpTdPFjlVu6//dBRUhWeg9vMsSEU9Q==
X-Received: by 2002:a05:620a:1a03:b0:79f:18f8:cdc7 with SMTP id af79cd13be357-7a1a13207camr151871485a.9.1721427188637;
        Fri, 19 Jul 2024 15:13:08 -0700 (PDT)
Received: from ldmartin-desk2.lan ([134.134.139.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19907b3f9sm132026985a.119.2024.07.19.15.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 15:13:07 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH kmod] Use SPDX header for license
Date: Fri, 19 Jul 2024 17:12:49 -0500
Message-ID: <20240719221249.376162-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drop the lengthy license from each file and just use SPDX like most
projects nowadays.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 libkmod/libkmod-builtin.c     | 18 ++------------
 libkmod/libkmod-config.c      | 20 +++-------------
 libkmod/libkmod-elf.c         | 19 +++------------
 libkmod/libkmod-file.c        | 19 +++------------
 libkmod/libkmod-index.c       | 19 +++------------
 libkmod/libkmod-index.h       | 19 +++------------
 libkmod/libkmod-list.c        | 19 +++------------
 libkmod/libkmod-module.c      | 19 +++------------
 libkmod/libkmod-signature.c   | 19 +++------------
 libkmod/libkmod.c             | 19 +++------------
 libkmod/libkmod.h             | 19 +++------------
 shared/array.c                | 19 +++------------
 shared/hash.c                 | 19 +++------------
 shared/macro.h                | 20 ++++------------
 shared/scratchbuf.c           | 19 +++------------
 shared/strbuf.c               | 19 ++-------------
 shared/util.c                 | 21 +++-------------
 shell-completion/bash/kmod    | 20 +++-------------
 testsuite/delete_module.c     | 17 +++----------
 testsuite/init_module.c       | 18 +++-----------
 testsuite/path.c              | 17 +++----------
 testsuite/test-array.c        | 16 ++-----------
 testsuite/test-blacklist.c    | 17 +++----------
 testsuite/test-dependencies.c | 17 +++----------
 testsuite/test-depmod.c       | 17 +++----------
 testsuite/test-hash.c         | 16 ++-----------
 testsuite/test-init.c         | 17 +++----------
 testsuite/test-initstate.c    | 16 ++-----------
 testsuite/test-list.c         | 16 ++-----------
 testsuite/test-loaded.c       | 18 ++++----------
 testsuite/test-modinfo.c      | 17 +++----------
 testsuite/test-modprobe.c     | 17 +++----------
 testsuite/test-new-module.c   | 17 +++----------
 testsuite/test-scratchbuf.c   | 16 ++-----------
 testsuite/test-strbuf.c       | 16 ++-----------
 testsuite/test-testsuite.c    | 17 +++----------
 testsuite/test-user.c         | 14 +----------
 testsuite/test-util.c         | 19 ++++-----------
 testsuite/testsuite.c         | 17 +++----------
 testsuite/testsuite.h         | 17 +++----------
 testsuite/uname.c             | 17 +++----------
 tools/depmod.c                | 45 ++++-------------------------------
 tools/insmod.c                | 19 +++------------
 tools/kmod.c                  | 19 +++------------
 tools/kmod.h                  | 19 +++------------
 tools/log.c                   | 19 +++------------
 tools/log.h                   | 19 +++------------
 tools/lsmod.c                 | 19 +++------------
 tools/modinfo.c               | 19 +++------------
 tools/modprobe.c              | 19 +++------------
 tools/rmmod.c                 | 19 +++------------
 tools/static-nodes.c          | 23 ++++--------------
 52 files changed, 153 insertions(+), 818 deletions(-)

diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
index 65334a8..3c1b0d1 100644
--- a/libkmod/libkmod-builtin.c
+++ b/libkmod/libkmod-builtin.c
@@ -1,20 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel built-in modules
- *
- * Copyright (C) 2019  Alexey Gladkov <gladkov.alexey@gmail.com>
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
+ * Copyright (C) 2019 Alexey Gladkov <gladkov.alexey@gmail.com>
  */
 
 #include <sys/types.h>
diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index a571b6b..c39e07d 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
- * Copyright (C) 2013  Intel Corporation. All rights reserved.
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <ctype.h>
diff --git a/libkmod/libkmod-elf.c b/libkmod/libkmod-elf.c
index 933825b..7a262d6 100644
--- a/libkmod/libkmod-elf.c
+++ b/libkmod/libkmod-elf.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <assert.h>
diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index 52490fb..5998a1d 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/libkmod/libkmod-index.c b/libkmod/libkmod-index.c
index 6a34c8d..3fd65f4 100644
--- a/libkmod/libkmod-index.c
+++ b/libkmod/libkmod-index.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <arpa/inet.h>
diff --git a/libkmod/libkmod-index.h b/libkmod/libkmod-index.h
index db671b0..a3d67fa 100644
--- a/libkmod/libkmod-index.h
+++ b/libkmod/libkmod-index.h
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #pragma once
diff --git a/libkmod/libkmod-list.c b/libkmod/libkmod-list.c
index 7623693..e4b1925 100644
--- a/libkmod/libkmod-list.c
+++ b/libkmod/libkmod-list.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <stdlib.h>
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 5c26e03..793da21 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <assert.h>
diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index 80f6447..d59ea13 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - module signature display
- *
- * Copyright (C) 2013 Michal Marek, SUSE
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
+ * Copyright © 2013 Michal Marek, SUSE
+ * Copyright © 2015-2024 Intel Corporation
  */
 
 #include <endian.h>
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 213b424..5efa968 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <assert.h>
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index fce66d1..ca731cb 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #pragma once
diff --git a/shared/array.c b/shared/array.c
index c2e2e14..2b424c7 100644
--- a/shared/array.c
+++ b/shared/array.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <assert.h>
diff --git a/shared/hash.c b/shared/hash.c
index a87bc50..41f943e 100644
--- a/shared/hash.c
+++ b/shared/hash.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/shared/macro.h b/shared/macro.h
index b59f7dc..fa35ec0 100644
--- a/shared/macro.h
+++ b/shared/macro.h
@@ -1,21 +1,9 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod - interface to kernel module operations
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
+
 #pragma once
 
 #include <stddef.h>
diff --git a/shared/scratchbuf.c b/shared/scratchbuf.c
index 8d9eb83..499cda3 100644
--- a/shared/scratchbuf.c
+++ b/shared/scratchbuf.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod - interface to kernel module operations
- *
- * Copyright (C) 2016  Intel Corporation. All rights reserved.
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
+ * Copyright © 2016-2024 Intel Corporation
  */
+
 #include "scratchbuf.h"
 
 #include <errno.h>
diff --git a/shared/strbuf.c b/shared/strbuf.c
index a69d914..0f8378f 100644
--- a/shared/strbuf.c
+++ b/shared/strbuf.c
@@ -1,21 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * libkmod - interface to kernel module operations
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
- * Copyright (C) 2014  Intel Corporation. All rights reserved.
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
+ * Copyright © 2024 Intel Corporation
  */
 
 #include <assert.h>
diff --git a/shared/util.c b/shared/util.c
index 437bc69..81694c8 100644
--- a/shared/util.c
+++ b/shared/util.c
@@ -1,22 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod - interface to kernel module operations
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
- * Copyright (C) 2012  Lucas De Marchi <lucas.de.marchi@gmail.com>
- * Copyright (C) 2013-2014  Intel Corporation. All rights reserved.
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <assert.h>
diff --git a/shell-completion/bash/kmod b/shell-completion/bash/kmod
index f530836..0a494ce 100644
--- a/shell-completion/bash/kmod
+++ b/shell-completion/bash/kmod
@@ -1,22 +1,8 @@
-# kmod completion                                          -*- shell-script -*-
-#
-# This file is part of kmod.
+#!/usr/bin/env bash
+# SPDX-License-Identifier: LGPL-2.1-or-later
 #
 # Copyright 2010 Ran Benita
-# Copyright (C) 2013  Intel Corporation. All rights reserved.
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
+# Copyright © 2013-2024 Intel Corporation
 
 __contains_word () {
         local word=$1; shift
diff --git a/testsuite/delete_module.c b/testsuite/delete_module.c
index f3ae20b..1c2fb27 100644
--- a/testsuite/delete_module.c
+++ b/testsuite/delete_module.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <assert.h>
diff --git a/testsuite/init_module.c b/testsuite/init_module.c
index 503e703..ccbcae1 100644
--- a/testsuite/init_module.c
+++ b/testsuite/init_module.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
- * Copyright (C) 2012-2013  Lucas De Marchi <lucas.de.marchi@gmail.com>
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #ifndef HAVE_FINIT_MODULE
diff --git a/testsuite/path.c b/testsuite/path.c
index 00935fb..8c85e8f 100644
--- a/testsuite/path.c
+++ b/testsuite/path.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 /* We unset _FILE_OFFSET_BITS here so we can override both stat and stat64 on
diff --git a/testsuite/test-array.c b/testsuite/test-array.c
index ef1e1e9..444823f 100644
--- a/testsuite/test-array.c
+++ b/testsuite/test-array.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C)  2014 Intel Corporation. All rights reserved.
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
+ * Copyright © 2014-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/testsuite/test-blacklist.c b/testsuite/test-blacklist.c
index 969567d..ca0a4f9 100644
--- a/testsuite/test-blacklist.c
+++ b/testsuite/test-blacklist.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/testsuite/test-dependencies.c b/testsuite/test-dependencies.c
index 38f5fc1..feac47f 100644
--- a/testsuite/test-dependencies.c
+++ b/testsuite/test-dependencies.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index eaa5b1a..a836211 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/testsuite/test-hash.c b/testsuite/test-hash.c
index 1bea04e..536dfad 100644
--- a/testsuite/test-hash.c
+++ b/testsuite/test-hash.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C)  2014 Intel Corporation. All rights reserved.
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
+ * Copyright © 2014-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/testsuite/test-init.c b/testsuite/test-init.c
index edbfc23..4ec24d0 100644
--- a/testsuite/test-init.c
+++ b/testsuite/test-init.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/testsuite/test-initstate.c b/testsuite/test-initstate.c
index 9332e8f..2ed1e17 100644
--- a/testsuite/test-initstate.c
+++ b/testsuite/test-initstate.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2015  Intel Corporation. All rights reserved.
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
+ * Copyright © 2015-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/testsuite/test-list.c b/testsuite/test-list.c
index 535e8d7..a5b7365 100644
--- a/testsuite/test-list.c
+++ b/testsuite/test-list.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C)  2015 Intel Corporation. All rights reserved.
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
+ * Copyright © 2015-2024 Intel Corporation
  */
 
 #include <stdio.h>
diff --git a/testsuite/test-loaded.c b/testsuite/test-loaded.c
index 9d5814f..d2faa1b 100644
--- a/testsuite/test-loaded.c
+++ b/testsuite/test-loaded.c
@@ -1,20 +1,10 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
+
 #include <errno.h>
 #include <inttypes.h>
 #include <stddef.h>
diff --git a/testsuite/test-modinfo.c b/testsuite/test-modinfo.c
index 373dc95..5473d45 100644
--- a/testsuite/test-modinfo.c
+++ b/testsuite/test-modinfo.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index 6a824c9..dd2732a 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/testsuite/test-new-module.c b/testsuite/test-new-module.c
index 9872b78..4efde1b 100644
--- a/testsuite/test-new-module.c
+++ b/testsuite/test-new-module.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/testsuite/test-scratchbuf.c b/testsuite/test-scratchbuf.c
index 6d86957..367d755 100644
--- a/testsuite/test-scratchbuf.c
+++ b/testsuite/test-scratchbuf.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C)  2016 Intel Corporation. All rights reserved.
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
+ * Copyright © 2016-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/testsuite/test-strbuf.c b/testsuite/test-strbuf.c
index c98c91d..f021ce6 100644
--- a/testsuite/test-strbuf.c
+++ b/testsuite/test-strbuf.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C)  2014 Intel Corporation. All rights reserved.
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
+ * Copyright © 2014-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/testsuite/test-testsuite.c b/testsuite/test-testsuite.c
index c77c4bb..2d6405c 100644
--- a/testsuite/test-testsuite.c
+++ b/testsuite/test-testsuite.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
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
index e3243e8..3538966 100644
--- a/testsuite/test-util.c
+++ b/testsuite/test-util.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
- * Copyright (C) 2012  Pedro Pedruzzi
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2012  Pedro Pedruzzi
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <fcntl.h>
diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
index 6602aaf..dd70030 100644
--- a/testsuite/testsuite.c
+++ b/testsuite/testsuite.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <dirent.h>
diff --git a/testsuite/testsuite.h b/testsuite/testsuite.h
index 4b2565c..1f46891 100644
--- a/testsuite/testsuite.h
+++ b/testsuite/testsuite.h
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #pragma once
diff --git a/testsuite/uname.c b/testsuite/uname.c
index 27f92d5..4ec2036 100644
--- a/testsuite/uname.c
+++ b/testsuite/uname.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * Copyright (C) 2012-2013  ProFUSION embedded systems
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <dlfcn.h>
diff --git a/tools/depmod.c b/tools/depmod.c
index 8e9e2d1..c87eb1b 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1,22 +1,11 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod-depmod - calculate modules.dep  using libkmod.
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2008  Alan Jenkins <alan-jenkins@tuffmail.co.uk>.
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
+#include <arpa/inet.h>
 #include <assert.h>
 #include <ctype.h>
 #include <dirent.h>
@@ -129,31 +118,7 @@ static inline void _show(const char *fmt, ...)
 }
 #define SHOW(...) _show(__VA_ARGS__)
 
-
-/* binary index write *************************************************/
-#include <arpa/inet.h>
-/* BEGIN: code from module-init-tools/index.c just modified to compile here.
- *
- * Original copyright:
- *   index.c: module index file shared functions for modprobe and depmod
- *   Copyright (C) 2008  Alan Jenkins <alan-jenkins@tuffmail.co.uk>.
- *
- *   These programs are free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with these programs.  If not, see <http://www.gnu.org/licenses/>.
- */
-
 /* see documentation in libkmod/libkmod-index.c */
-
 #define INDEX_MAGIC 0xB007F457
 #define INDEX_VERSION_MAJOR 0x0002
 #define INDEX_VERSION_MINOR 0x0001
diff --git a/tools/insmod.c b/tools/insmod.c
index c422971..83eb7c6 100644
--- a/tools/insmod.c
+++ b/tools/insmod.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod-insmod - insert modules into linux kernel using libkmod.
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/tools/kmod.c b/tools/kmod.c
index e1a73be..c061a35 100644
--- a/tools/kmod.c
+++ b/tools/kmod.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod - one tool to rule them all
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/tools/kmod.h b/tools/kmod.h
index 1770786..f18176b 100644
--- a/tools/kmod.h
+++ b/tools/kmod.h
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod - one tool to rule them all
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #pragma once
diff --git a/tools/log.c b/tools/log.c
index 3317a35..183e3af 100644
--- a/tools/log.c
+++ b/tools/log.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod - log infrastructure
- *
- * Copyright (C) 2012-2013  ProFUSION embedded systems
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/tools/log.h b/tools/log.h
index d55a4c6..4ff2d1d 100644
--- a/tools/log.h
+++ b/tools/log.h
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod - log infrastructure
- *
- * Copyright (C) 2012-2013  ProFUSION embedded systems
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
+ * Copyright © 2012-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <stdarg.h>
diff --git a/tools/lsmod.c b/tools/lsmod.c
index d9a27f2..228a042 100644
--- a/tools/lsmod.c
+++ b/tools/lsmod.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod-lsmod - list modules from linux kernel using libkmod.
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/tools/modinfo.c b/tools/modinfo.c
index cacc32d..441a93c 100644
--- a/tools/modinfo.c
+++ b/tools/modinfo.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod-modinfo - query kernel module information using libkmod.
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/tools/modprobe.c b/tools/modprobe.c
index 4328da6..1b6bc0b 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod-modprobe - manage linux kernel modules using libkmod.
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <assert.h>
diff --git a/tools/rmmod.c b/tools/rmmod.c
index 3942e7b..ceb536f 100644
--- a/tools/rmmod.c
+++ b/tools/rmmod.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod-rmmod - remove modules from linux kernel using libkmod.
- *
- * Copyright (C) 2011-2013  ProFUSION embedded systems
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
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
diff --git a/tools/static-nodes.c b/tools/static-nodes.c
index 5ef3743..01919ed 100644
--- a/tools/static-nodes.c
+++ b/tools/static-nodes.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
- * kmod-static-nodes - manage modules.devname
- *
- * Copyright (C) 2004-2012 Kay Sievers <kay@vrfy.org>
- * Copyright (C) 2011-2013  ProFUSION embedded systems
- * Copyright (C) 2013 Tom Gundersen <teg@jklm.no>
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
+ * Copyright © 2004-2012 Kay Sievers <kay@vrfy.org>
+ * Copyright © 2011-2013 ProFUSION embedded systems
+ * Copyright © 2013 Tom Gundersen <teg@jklm.no>
+ * Copyright © 2013-2024 Intel Corporation
  */
 
 #include <errno.h>
-- 
2.45.2

