Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726E6A023
	for <linux-modules@vger.kernel.org>; Sat, 17 Feb 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708185690; cv=none; b=Oz7AhK8lCXv8Vtu7e/VM7YKhhNM49qb+BVsH5NMivlNOl6A9mj2pGQ1JvI9LDrLV43jwWQ7+pm0Y5NHPnkPxmi9Im56IFYr8SdK3g2HzIvErFm+/yV+KYgAoCAaTgfJvhbsBTzCCPX2YVFmt5jXz6Z6IihLf3qGzlvoPi5FUxzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708185690; c=relaxed/simple;
	bh=WRpGWSCv1QgmBFa9Z6ilAojoZZajV/qjqUstkQKgQ2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GmdNqVPhwBl+e/YsCecW2xo9xAe2oE0pnq5v1y5K0IWslnLHvsksi2XICN87KTpH7Edf+q3mW46yubrPCh7Vik1vgx+bYXbWPzmN49XdRdJg0pwtBWsQPTd3bCiSZlf6jzoEt74uIiYec80vNMaI6xNYahPedkO0+WyGz5Tkt98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxID+fQR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxID+fQR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 874D9C433C7;
	Sat, 17 Feb 2024 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708185689;
	bh=WRpGWSCv1QgmBFa9Z6ilAojoZZajV/qjqUstkQKgQ2s=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=AxID+fQRbFCvzTfbJM1yhfV6dKbrfRMeLqZw3Zucqj2hbPTOx6aeSxiDuUS5/ez5I
	 Rd7ZQlZbpenhpqXiML5BUPYeTuh6KQqRTrFUrfyRaKhvTNI0uca79VdHXu5d4llfy2
	 SzsKY8NkBRJn5trI0MyFbpng7PCC1R7cBH9LwUCk09fBNAVke58IP1wRMrX1t0fVAA
	 NX7T6Qcmdm/tp7Qvuwz4cUbIz6ByDqPmFlaaprg/gDcWuyH8C8mnSw7nj0nEvlfDmd
	 agfgIwVUsQ8safw1KiDOBa9zoaa8ri9ksEBWlb9qbi51UgmL6XwMxkzWAXxDWgIJo0
	 /gQiF9vV126Dg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C71C48BC3;
	Sat, 17 Feb 2024 16:01:29 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Sat, 17 Feb 2024 16:01:26 +0000
Subject: [PATCH kmod] man: silence autoconf warnings
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-autoconf-manpage-warns-v1-1-e1570cfc286e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFXY0GUC/x2MywqAIBAAf0X2nKASBf1KdNhsrT20hvaC6N+Tj
 sMw80CmxJShUw8kOjlzlAK2UuAXlJk0T4XBGVcbZ1uNxx59lKBXlA2LvzBJ1oZoNAEb1/oAJd4
 SBb7/cT+87wdX+00xaAAAAA==
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708185688; l=3746;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=+yfi/genz56uVITFQM5UuX+HEhtsNJ5sllriAqv0t2M=;
 b=69qVvghz704GS9SitTQ2SOo1wyBueqpX7F/Kiqp6k1c4oU7W6JdTVzi0/ZH4rDBI9g1Ilsu+z
 hg7KDc9xQ89CqUm7qIdxTt1EoesbpLjJ2Q5p9d+reSNrw7wtMYaBJOx
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

Currently we have a pattern rule, which effective states that two output
files are produced - %.5 and %.8. Although that's not the case in
practise, since each input xml will be generated to a single manual
page.

Add the manpage section as part of the xml filename and tweak the
pattern (match) rule, accordingly.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
Noticed, while wondering if I should add sanitizer support to the
autoconf build.

A few, random questions:
 - are there any objections to adding sanitizers support?
 - would a meson.build be acceptable? Giving us sanitizers, coverage,
   scan-build, etc out of the box
 - writing xml is fiddly, would people be OK if we convert them to
   scdoc? here are some examples of the raw file [1] vs the man [2]

[1] https://gitlab.alpinelinux.org/alpine/apk-tools/-/raw/master/doc/apk-add.8.scd?ref_type=heads
[2] https://man.archlinux.org/man/extra/apk-tools/apk-add.8.en
---
 man/Makefile.am                            | 11 +++++++++--
 man/{depmod.xml => depmod.8.xml}           |  0
 man/{depmod.d.xml => depmod.d.5.xml}       |  0
 man/{insmod.xml => insmod.8.xml}           |  0
 man/{kmod.xml => kmod.8.xml}               |  0
 man/{modinfo.xml => modinfo.8.xml}         |  0
 man/{modprobe.xml => modprobe.8.xml}       |  0
 man/{modprobe.d.xml => modprobe.d.5.xml}   |  0
 man/{modules.dep.xml => modules.dep.5.xml} |  0
 man/{rmmod.xml => rmmod.8.xml}             |  0
 10 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/man/Makefile.am b/man/Makefile.am
index f550091..d62ff21 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -13,10 +13,10 @@ dist_man_MANS = $(MAN5) $(MAN8) $(MAN_STUB)
 modules.dep.bin.5: modules.dep.5
 endif
 
-EXTRA_DIST = $(MAN5:%.5=%.xml) $(MAN8:%.8=%.xml)
+EXTRA_DIST = $(MAN5:%.5=%.5.xml) $(MAN8:%.8=%.8.xml)
 CLEANFILES = $(dist_man_MANS)
 
-%.5 %.8: %.xml
+define generate_manpage
 	$(AM_V_XSLT)if [ '$(distconfdir)' != '/lib' ] ; then \
 		sed -e 's|@DISTCONFDIR@|$(distconfdir)|g' $< ; \
 	else \
@@ -29,3 +29,10 @@ CLEANFILES = $(dist_man_MANS)
 		--stringparam man.output.quietly 1 \
 		--param funcsynopsis.style "'ansi'" \
 		http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl -
+endef
+
+%.5: %.5.xml
+	$(generate_manpage)
+
+%.8: %.8.xml
+	$(generate_manpage)
diff --git a/man/depmod.xml b/man/depmod.8.xml
similarity index 100%
rename from man/depmod.xml
rename to man/depmod.8.xml
diff --git a/man/depmod.d.xml b/man/depmod.d.5.xml
similarity index 100%
rename from man/depmod.d.xml
rename to man/depmod.d.5.xml
diff --git a/man/insmod.xml b/man/insmod.8.xml
similarity index 100%
rename from man/insmod.xml
rename to man/insmod.8.xml
diff --git a/man/kmod.xml b/man/kmod.8.xml
similarity index 100%
rename from man/kmod.xml
rename to man/kmod.8.xml
diff --git a/man/modinfo.xml b/man/modinfo.8.xml
similarity index 100%
rename from man/modinfo.xml
rename to man/modinfo.8.xml
diff --git a/man/modprobe.xml b/man/modprobe.8.xml
similarity index 100%
rename from man/modprobe.xml
rename to man/modprobe.8.xml
diff --git a/man/modprobe.d.xml b/man/modprobe.d.5.xml
similarity index 100%
rename from man/modprobe.d.xml
rename to man/modprobe.d.5.xml
diff --git a/man/modules.dep.xml b/man/modules.dep.5.xml
similarity index 100%
rename from man/modules.dep.xml
rename to man/modules.dep.5.xml
diff --git a/man/rmmod.xml b/man/rmmod.8.xml
similarity index 100%
rename from man/rmmod.xml
rename to man/rmmod.8.xml

---
base-commit: b29704cd448aaa455dba4e656fc0f0d3c686df3f
change-id: 20240217-autoconf-manpage-warns-0eeb0fa627cf

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>

