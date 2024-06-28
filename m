Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698F4481D7;
	Fri, 28 Jun 2024 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719571178; cv=none; b=QglxXTe7lapf11sVDodasV4rXvmN07bN5bjByZNCSWm9r9ppexh8n0UgjbF4MFWg2bRxsklZ3UHCVWedtupZ+3KyU5Gk3Cltfx+xMoSAcxxnqVT3PLN+8sipJw5QdloBrLKHe6IhLbKlCIKvtvB28uaIH+pjo/Oe5xuEGhgSQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719571178; c=relaxed/simple;
	bh=s9lOKFc4gcO+LDvKXl6H3jR7MqKnwxk2tRCqRHFNMtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pjEBMWsM6DU/UnDUulg9Ei0z2bL1xa7PxPDnAftsIjHA4MErY9P+fqZh/kyP/Ltl+1f8MIo2NwhxLXYK/SmSf9rbhCBIf69+A1xWzTcFcXF0v6a9kk0XiILYh4TYfa4T2+kFEt3yLjiM2Vq3Bx7nWh31k81L1usaLBdY8ycRJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuomXuDq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuomXuDq"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f8395a530dso2161945ad.0;
        Fri, 28 Jun 2024 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719571176; x=1720175976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXpXg9YTB6eajBI0oY9nEykHAkxkknrQk8vZaZGHMas=;
        b=GuomXuDq4aP3K5cVp8isRGhttElVBTPAIqovbOe8icF6/ScIUfsJUgiTSn4qPl1q1a
         bQTc2TvanOMnBCo2LyWAf9go+sl+t3/VzurDigDnI61YhouY11BYsYqMQJcfnOkU1KW3
         7PzdG0NtQhtJwzcUUZ6FS5ESiKQDm79Nci5h7FHSov67zdube7Tx+V8Q+/Rxp7JeycvY
         QQrrNYyt78Xb+SNEPyDrCYSc/v+0nwxwJUlMF6K3GRnxpPKr/racSBIU/ylJlJqv4b1X
         mMymMpiCjPZhZ0V385V7weOXot+vFFBRP8T0USMVsagVvlEBmPvdejCKhg3qSwCTYNVO
         L2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719571176; x=1720175976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXpXg9YTB6eajBI0oY9nEykHAkxkknrQk8vZaZGHMas=;
        b=hDIJ/h/qSyPR+/tY1QbQ2Au+/suSfkhwLQzgmolJGMBm0FAioJCinbUcaeDR0CV8YH
         ymiPzYV2CGwlGAxZClxyVHbHGF5sYLCFJ9oM9JvMNvX8ZsdVFvBnKpZ3CT5DLlmEaXCC
         jQa5DOSAWxcCHlcquwTUF9xd3rFbR1KFMEpQJursbqJMjLIZBd9Qt4NhtV5PvcEpxt6j
         mDjI2RaibMOt/eVNAgeIbnufDXCGHl2KB0mgA2bY3Q56wL0JKUpx4cvXQ1ctvLJ/DGr9
         e3sUFhocLGAlHcG5yKU8hz96R69m314z5FCLAHjB8nXNENLsmUtihtRulDA8ZOQkg4GY
         wjwA==
X-Forwarded-Encrypted: i=1; AJvYcCUudy86iIh2xqBxXl8Oa1R0HtHuiU2J0B/vg+bpdM0lgff3XGsHeM5OvRduzG8VoAij3a1Fm3ruoVI88bGZyyOINHE9rcnhlwtaZ7gY
X-Gm-Message-State: AOJu0YysBSAVPKKhxPtn/lLRClxW0AM5jMdX0pgAqsy8HHwG+hceZ0iN
	2RlhufpkbPS5q+Ws6yc6TfMyOZPCHK5YHMOcOd/3YfmZ5RbQoLpF
X-Google-Smtp-Source: AGHT+IHwLvLRz5doDoofDV7sc4qT6KEsIxSql/KM5jzssjx10EIOf41YDq8JuD13FLb2WCGqaAMJWQ==
X-Received: by 2002:a17:902:ee91:b0:1f8:6971:c35d with SMTP id d9443c01a7336-1fa23f9bea7mr127152015ad.68.1719571176479;
        Fri, 28 Jun 2024 03:39:36 -0700 (PDT)
Received: from localhost.localdomain ([114.111.24.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a87sm12302265ad.94.2024.06.28.03.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 03:39:36 -0700 (PDT)
From: Yusong Gao <a869920004@gmail.com>
To: mcgrof@kernel.org
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	a869920004@gmail.com
Subject: [PATCH v3] module: Add log info for verifying module signature
Date: Fri, 28 Jun 2024 10:39:23 +0000
Message-Id: <20240628103923.1677347-1-a869920004@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add log information in kernel-space when loading module failures.
Try to load the unsigned module and the module with bad signature
when set 1 to /sys/module/module/parameters/sig_enforce.

Unsigned module case:
(linux) insmod unsigned.ko
[   18.714661] Loading of unsigned module is rejected
insmod: can't insert 'unsigned.ko': Key was rejected by service
(linux)

Bad signature module case:
(linux) insmod bad_signature.ko
insmod: can't insert 'bad_signature.ko': Key was rejected by service
(linux)

There have different logging behavior the bad signature case only log
in user-space, add log info for fatal errors in module_sig_check().

Signed-off-by: Yusong Gao <a869920004@gmail.com>
---
V3: Clarify the message type and the error code meaning.
V2: Change print level from notice to debug.
---
 kernel/module/signing.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index a2ff4242e623..826cdab8e3e4 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -67,6 +67,31 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 				      NULL, NULL);
 }
 
+static const char *mod_decode_error(int errno)
+{
+	char *errstr = "Unrecognized error";
+
+	switch (errno) {
+	case -ENOMEM:
+		errstr = "Out of memory";
+		break;
+	case -EINVAL:
+		errstr = "Invalid argument";
+		break;
+	case -EBADMSG:
+		errstr = "Invaild module signature format";
+		break;
+	case -EMSGSIZE:
+		errstr = "Message too long";
+		break;
+	case -EKEYREJECTED:
+		errstr = "Key was rejected by service";
+		break;
+	}
+
+	return errstr;
+}
+
 int module_sig_check(struct load_info *info, int flags)
 {
 	int err = -ENODATA;
@@ -113,6 +138,8 @@ int module_sig_check(struct load_info *info, int flags)
 		 * unparseable signatures, and signature check failures --
 		 * even if signatures aren't required.
 		 */
+		pr_debug("Verifying module signature failed: %s\n",
+			 mod_decode_error(err));
 		return err;
 	}
 
-- 
2.34.1

