Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4862145A0B
	for <linux-modules@vger.kernel.org>; Thu,  6 Mar 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278107; cv=none; b=nDtG1tfoZmeh0bBu55FXdO2U7+ny4XhCe3dw7aaHLUppN1lHN8lpClqwDdbLM6hNDgy9NJ4K7McBDRFCdbXnAFmlxmWQKhK7djjqGxKPlS2sgsva8NjZe8dADF4Uj/a+k+qkIXgqLrt9LdhDzggGILAx0OUuf/nnevcbolkMx0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278107; c=relaxed/simple;
	bh=NnwwiFX0fgN9MDN62lMjnICri18W7lMtlk90+146rbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T5ebh5KQSouqY/kEUHmz38xy5SXU/l8Hy253izbqJcdlSdmv/RmTiqZf5KjO9w1ewzi9pXuJDwl3nOvAI9II5CMXgsaqxNA/C3NGO+/XyIDxRtY74AT0J9rTP2QPuC4dLcSE3SBCi2hH7wTDRhMk7EkC5tdc520VmjGOpKVUh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M59Msc71; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M59Msc71"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso5632875e9.0
        for <linux-modules@vger.kernel.org>; Thu, 06 Mar 2025 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741278104; x=1741882904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wW8fv/c/SOuj1ifoxIC+BzegNrFlqpqBNUShKNP4Jmc=;
        b=M59Msc71zCvXZCg7C9fT4ifu+PMb8YVhFgYWQziMFfeclU4iTDry0AAwufibJ3313z
         czgu+Yr257c0oqd8sMBAkIB5DEgdMmuJNyA4RFKlB822ckqYD6VQbUUP30rS/r6s/XK6
         FC5sxI1Z+t7Q26ukswAkO44hmaAIFlnNj/CJMSBZUbzWDZ2aASFAE5r4FMHPCoV1cV0x
         PW5gL6DHJ1vONuKoyG3gQyRqbeTffbDibT1anI/jJiAQ0pNwXeLIfR2j8p/22ymyVxjQ
         nSvEZ+i+JpOk11TIATOx69Ot7swrXwDr35nYeNyZuclT47A6AnpHYv8WRmM9u2q0LzMV
         O/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278104; x=1741882904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wW8fv/c/SOuj1ifoxIC+BzegNrFlqpqBNUShKNP4Jmc=;
        b=HLd2fRd2fPFia2nRK81NQcycUNMnt2u243sprCiW0aYVnSD2M1h2IJeHIwK1bukjHk
         79H/aoZSGQx1AgmomqTDc/0D6ZvWOYhO6jop+KCldFpuHfKABMouQ5oBxEveLTGPjOtn
         MCJbLvRIqr3s6Imdx7QbaOGqYySlyGzM7fD5KTzNPacPbUwonJnM8lgS2nbfouRou+Ok
         tImTdHAiMxY6z6l5Lyvgaa162eSxWjn4WcI83MRQPXkv2TqlDbMbBKWLqTtv4HLCEoEf
         ePlGp+ANWGNzTH597O7GD8wH0vu20bVrasgzy+C4LFpIc4NS5hM9IKdJ1ACDdHI+uvSq
         M9cA==
X-Forwarded-Encrypted: i=1; AJvYcCXFE0i7LsGShzRGeA/0MCmcPNMcT5XZahptD8K52FG9DzVQUpKjotJ3Cd9AQK1U/FNTmOYwXNJGcTK5gn9h@vger.kernel.org
X-Gm-Message-State: AOJu0YycRSGpjAWzPt45M1lku6yu/YzRKuUePasqbVXSMolnuibbAT2C
	GjAGHTy+QJM+TkGomULK8gITOiRWBzB/DAx4UU/K/6TrtY0YaxQ8CR0Fhj/5J6Q=
X-Gm-Gg: ASbGncsSSkDY7KDGtTgwmnPEa09+eWoKCBxiVc2BG6p3hdlS83UDQRrvOTX/ImoCEh1
	NMW4X7CjmTTkYKoG8qQ6p+pRa8YrgwnCidD7GaS93FOmuLqlAcJPflGh3qxXBhheYVGeYr7Gzvm
	87c2h1/Vo/b4S/lFI9aVniwGvzptgBqaHg9J+GE2WcKngaFWb9EwxnkrbxV5EteWVVMtbhGUVqL
	U7iFpaI9qkzaNjEcrYmEug9HE7q7vPmeiOFBOtQVaJ2cwHA50FONO6CGaW9LlAQKsYOry3mKq5n
	iAweFdmloJ6+kWFnQDqs2KHiX+dy/pXeaeU1jeA5RUDojNQY
X-Google-Smtp-Source: AGHT+IFHQXHU03Zs/hnxG2LMsd+FqGQL18YfZKdZoNQgvKHJ+pNPDgffKMalooCg9O9MuolKgzLHnQ==
X-Received: by 2002:a5d:5f84:0:b0:390:f55b:ba94 with SMTP id ffacd0b85a97d-3911f73fa74mr7220020f8f.13.1741278104005;
        Thu, 06 Mar 2025 08:21:44 -0800 (PST)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0193bfsm2507741f8f.55.2025.03.06.08.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:21:43 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update the MODULE SUPPORT section
Date: Thu,  6 Mar 2025 17:20:59 +0100
Message-ID: <20250306162117.18876-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change my role for MODULE SUPPORT from a reviewer to a maintainer. We
started to rotate its maintainership and I currently look after the modules
tree. This not being reflected in MAINTAINERS proved to confuse folks.

Add lib/tests/module/ and tools/testing/selftests/module/ to maintained
files. They were introduced previously by commit 84b4a51fce4c ("selftests:
add new kallsyms selftests").

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..0c8a00b0b49b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15982,7 +15982,7 @@ F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 
 MODULE SUPPORT
 M:	Luis Chamberlain <mcgrof@kernel.org>
-R:	Petr Pavlu <petr.pavlu@suse.com>
+M:	Petr Pavlu <petr.pavlu@suse.com>
 R:	Sami Tolvanen <samitolvanen@google.com>
 R:	Daniel Gomez <da.gomez@samsung.com>
 L:	linux-modules@vger.kernel.org
@@ -15993,8 +15993,10 @@ F:	include/linux/kmod.h
 F:	include/linux/module*.h
 F:	kernel/module/
 F:	lib/test_kmod.c
+F:	lib/tests/module/
 F:	scripts/module*
 F:	tools/testing/selftests/kmod/
+F:	tools/testing/selftests/module/
 
 MONOLITHIC POWER SYSTEM PMIC DRIVER
 M:	Saravanan Sekar <sravanhome@gmail.com>

base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
-- 
2.43.0

