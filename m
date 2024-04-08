Received: from nc-smtp1.sdv.fr (nc-smtp1.sdv.fr [212.95.69.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B4146595
	for <linux-modules@vger.kernel.org>; Mon,  8 Apr 2024 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.95.69.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712608170; cv=none; b=emaS0K9cNAIF8/D76WI12+Axr+bH1yLR8nSwjW5ajJR12FB9ABmQqvtbzfW9oHkePkFzrylpJSgvat7B607ago+2fjZ/khwVcJmip8rrYToUuzOLvWiiMGReYGPZKeWlKEYIPboaMP2QSkMFoMWT3BOJ5do+FbQinSBjg5Bc0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712608170; c=relaxed/simple;
	bh=mWzCQPYooEZth/GcYC03GeoFUCWI4uKs4Vw846oR01E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bZ1acZ5Js8ijspEWUgakT4NN+P0u2CgtHE11yp8/FXIRiueqXzdKPuJvKMeC6CRvkg1EFH4aaL8v11XUdQPYYuTJYoSyqJhCfClCPKBJdnJ1SgdkiiKqX9mN3mS/ASEnRlqfv9CqdPF70mBDNwXDmHh0w+tJMXKYJuykQklLYpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skarnet.org; spf=pass smtp.mailfrom=skarnet.org; arc=none smtp.client-ip=212.95.69.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skarnet.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skarnet.org
Received: from skarnet.org (140.156.124.78.rev.sfr.net [78.124.156.140])
	by nc-smtp1.sdv.fr (Postfix) with SMTP id F2EA02101D
	for <linux-modules@vger.kernel.org>; Mon,  8 Apr 2024 22:22:01 +0200 (CEST)
Received: (qmail 34617 invoked from network); 8 Apr 2024 22:22:28 +0200
Received: from elzian.internal.skarnet.org. (HELO ?192.168.0.2?) ()
  by sinay.internal.skarnet.org. with SMTP; 8 Apr 2024 22:22:28 +0200
From: "Laurent Bercot" <ska-devel@skarnet.org>
To: linux-modules@vger.kernel.org
Subject: [PATCH] kmod/depmod: explicitly include the header for basename()
Date: Mon, 08 Apr 2024 20:22:01 +0000
Message-Id: <embe01a23a-c839-406f-b9f0-9b9dbd4bc5c2@e0f6f3eb.com>
Reply-To: "Laurent Bercot" <ska-devel@skarnet.org>
User-Agent: eM_Client/9.2.2157.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

  Hello list,

(Please Cc: me on the replies.)

  Recent versions of the musl libc declare basename() (and dirname())
exclusively in <libgen.h>, as specified by POSIX. If this header is
not properly included, when building kmod with musl, basename() is an
unknown symbol and will be assumed as returning int, which causes
problems as soon as kmod performs a printf("%s", basename(argv[0])),
e.g. in kmod_help(). (On x86_64, int is 32 bit, so the pointer address
is truncated, which causes a segfault on access.)

  Simply including libgen.h wherever basename() is used, i.e. depmod.c
and kmod.c, fixes the issue. It will print warnings because you store
the result in a const char *, but these are harmless and can be fixed
later.

  None of the kmod files seems to use dirname(), but several of them use
dirname as a symbol, including depmod.c, where it will shadow the libc's
dirname symbol. This does not cause a problem right now, but it might be
a good idea to rename the dirname variables at some point.


diff -rNU3 kmod-32.old/tools/depmod.c kmod-32/tools/depmod.c
--- kmod-32.old/tools/depmod.c  2023-12-06 16:34:31.000000000 +0100
+++ kmod-32/tools/depmod.c      2024-04-08 20:55:03.998592078 +0200
@@ -22,6 +22,7 @@
  #include <dirent.h>
  #include <errno.h>
  #include <getopt.h>
+#include <libgen.h>
  #include <limits.h>
  #include <regex.h>
  #include <stdio.h>
diff -rNU3 kmod-32.old/tools/kmod.c kmod-32/tools/kmod.c
--- kmod-32.old/tools/kmod.c    2024-02-20 23:10:55.000000000 +0100
+++ kmod-32/tools/kmod.c        2024-04-08 21:55:03.888577992 +0200
@@ -19,6 +19,7 @@

  #include <errno.h>
  #include <getopt.h>
+#include <libgen.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>

