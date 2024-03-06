Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BCC7FBCC
	for <linux-modules@vger.kernel.org>; Wed,  6 Mar 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737092; cv=none; b=buH1rvqQ8OAnS9CLMcJ5o80fJyRZaKpE6RulzdhpzgagXbMSKb16NUviILAYNmVet5D/9XL+jEPxz6wp7QWzTtPES9ErfROjvsTv8DbuyvsW7JDEWM5hbx3+jSR8YHeSDAqeuxhW1CoZWxZX130iBKgXaeoR5SC0OTQDtrqKyj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737092; c=relaxed/simple;
	bh=kEZl5EUzUyfSJ9C28NJue1al4E1cyBpw6oCX0LP13aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLjrdS1w/EFCWJrguV0IGzfs6EBQMW0TJLrpn6Zcf1fFQPgk7S3QBmDwdjgcUoFIjm70znnNeQJf+43fHumZ69Vmk9nUrRlfop4i2gwDe2dME8lFXb2voBiqmdWPfJOQPyEgcTXBvXDRI58m9JQhn1XJGqfWJMFg4bRTryjKICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9CXaUVs; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9CXaUVs"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42ee7fa077bso18838791cf.3
        for <linux-modules@vger.kernel.org>; Wed, 06 Mar 2024 06:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709737090; x=1710341890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sg5LxE8IL17Mv1EGclamAtdHQkNC2ZHR56eXveEEHDM=;
        b=N9CXaUVsldd3A/qVyvIHOMCP8josJ3CLy8q1SmqpR1SJaPZCwHs7IJiKIVAOi8gJx0
         kspLkjAh9EEuvQwVwXX+MAwtY1aqUstB+rcx2iI/lZ+vhP/5FV5UsQrZpGQKErt2aRYC
         eowlhykSb0NUWEzACWn+Orr+24Qv2CCh8qcstEcfc5sZ1wkxO+GS9694qek9bQr9fMOl
         oIotSielHo5QNpuCeAVE3gXVgDPE3/3j5t/n13mCUr77dpdrN4qf6xCzXyR0wS16IEMt
         pL+YdThPkFVUS4tin4vw/rH86z0Oh3Aa9TCq3v+fhUnr+zF3yZDkmtQBa1xHqH5KVnO2
         jqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709737090; x=1710341890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sg5LxE8IL17Mv1EGclamAtdHQkNC2ZHR56eXveEEHDM=;
        b=Zapltg6D9Nbn0IRD2aSlZHeec3eukRdAJf3QB9VBZAFJBPducxbN0O9V5DAP5v2RGx
         zE0TwMe4B+UiJkVYq1U6kFxQ0ppS2bBTVE+D4YJpydXeXXcyQqve7OBBodpxLJgFXE1+
         SUJ0m2SBZdQfxbjbnuAazplBZLjxMbZ3Lpis91vasHyVayf8fuHbno2uSilB+iPvRy4W
         I9mmnju7/cpVpEZpKSXag1XwPBY75ZfFUvPWLkOzr8JpKuwJmo8vnY6Do35v6HrxbylT
         zHSu+nw1pNYHpMJdSrc28N4+0xHh2uHvSEHazEN7w6pr28HsgVRdKxYVU0NTWbG6v0LL
         45Hw==
X-Gm-Message-State: AOJu0Yw0qtrYGuuyAOTfW0sEQ//SPzcGoIdHVfnv5H5rs8cw1C0xHknm
	4zItWVD/jUHhzW9aEL9QrQMPVKgp7LF16tu+wt1Bc7Bf+TM2RW2MN9PJeNXA
X-Google-Smtp-Source: AGHT+IGmYrZ1/PkTiGnEynESiHyYH4UAkJi+Yjtc+zP9Qrj8jOW7cSyAgCBbNAEqyudTB+xRUarF6w==
X-Received: by 2002:a05:622a:1703:b0:42d:e7be:d53d with SMTP id h3-20020a05622a170300b0042de7bed53dmr5501603qtk.29.1709737089432;
        Wed, 06 Mar 2024 06:58:09 -0800 (PST)
Received: from ldmartin-desk2.lan ([192.55.54.52])
        by smtp.gmail.com with ESMTPSA id bq16-20020a05622a1c1000b0042e8f150417sm6629861qtb.45.2024.03.06.06.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:58:08 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Emil Velikov <emil.l.velikov@gmail.com>
Subject: [PATCH] build: Allow to install over dirty dir
Date: Wed,  6 Mar 2024 08:58:04 -0600
Message-ID: <20240306145804.135709-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before commit e98cef6f3f8c ("make: install/uninstall tools symlinks to
kmod") it was possible to call `make install DESTDIR=<dir>` multiple
times. Use `ln -sf` so the symlink is always re-created.

It would be preferred to remove install in an empty dir, but there's
not a bad consequence of re-using the same, so let the user decide.
Fixes the following errors while installing for the second time:

	ln: failed to create symbolic link '/tmp/inst/usr/bin/insmod': File exists
	ln: failed to create symbolic link '/tmp/inst/usr/bin/lsmod': File exists
	ln: failed to create symbolic link '/tmp/inst/usr/bin/rmmod': File exists
	ln: failed to create symbolic link '/tmp/inst/usr/bin/depmod': File exists
	ln: failed to create symbolic link '/tmp/inst/usr/bin/modprobe': File exists
	ln: failed to create symbolic link '/tmp/inst/usr/bin/modinfo': File exists
	make[3]: *** [Makefile:2679: install-exec-hook] Error 1
	make[2]: *** [Makefile:2553: install-exec-am] Error 2
	make[1]: *** [Makefile:2439: install-am] Error 2
	make: *** [Makefile:1848: install-recursive] Error 1

Cc: Emil Velikov <emil.l.velikov@gmail.com>
Closes: https://github.com/kmod-project/kmod/issues/35
Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index d37b56d..2222c21 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -113,7 +113,7 @@ install-exec-hook:
 	fi
 if BUILD_TOOLS
 	for tool in insmod lsmod rmmod depmod modprobe modinfo; do \
-		$(LN_S) kmod $(DESTDIR)$(bindir)/$$tool; \
+		$(LN_S) -f kmod $(DESTDIR)$(bindir)/$$tool; \
 	done
 endif
 
-- 
2.43.2

