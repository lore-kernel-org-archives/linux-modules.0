Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBC228D8CF
	for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294177; cv=none; b=soXBbPwlj7e7aqpaLjIhlSCWbgks+K7dRlf6cFd6u3yl5miQWKjGV6Vbfy6EYXi/p1HUun28GpT3xiHfeH2MYdookILNdmJKlnTYiIRzobAP5RTMwxCfYBlfdlTB4M1PO/vdYvUYxtfqfYwZuQP3VRFoiVWxvm72GLb0mhgpSlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294177; c=relaxed/simple;
	bh=PirEDsPKzKZfF4lma/U6ABELtX2SsjTdnouDkKmFdHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsTNmed2HnZWm0/Owa1S7uE0gsEnkykWUTHC1s6WtxjwjFrME+xht/pUa8gCZvxNrOwgg0TmyyyO0hkclDMIjBS9q5Wlvw04VTAPIeGIl7gX8jstPJ9ABnOPMTEqyr7ywggRaL8IQZ4Kun/v7gS3g/pcPayq1G1gsxL1+6G+OzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fdc/Ksoy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fdc/Ksoy"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso29083715e9.2
        for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751294173; x=1751898973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtpZAHSxzBc52yNVlVB1MC/4zpT1HtcP/IJyN7kdpFo=;
        b=Fdc/KsoyxO07X+4I1KFRHthpL1FloKU88LNyvrysXSZ5opWS9U46fOH7pTYeeNg+bM
         O5euxNbL4LzB15ObmkRDTqfwIjomyuDaXf7kNRlqGwKTB+mssv+5CBeEkM9Jt5XoTJTf
         OZ3qaA79sKVFGUR3E2562pQcYRXMq9D7x5DFdNhtuQnz9VUcIzdFEoMU0DVDG4/4l8oi
         OOHTkmgoqfWyHwv9G5d+RLAOFPNICijIIeFzB+YMVtzqix7uo/Lt1AFh3Kp9UEeEEFyj
         TqT7+5w54JakWldteR6PHa76I9/qrhdkrrQMx7n3+IXlbqQ8VdZ8+EPcget2iGDOysXH
         NVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294173; x=1751898973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtpZAHSxzBc52yNVlVB1MC/4zpT1HtcP/IJyN7kdpFo=;
        b=NK+1nwDniHQiqyjI6Cv5JK5jqJb9qeNu6HZZ8AGL1UNI7+I3vjAokYgb5ez5tIj3aH
         4qHS+rctMoZY0Y9IJnNJqtx6ims4AbXscEb1gWyZRU81PqDm4pO3kcfsvKlRoCp3EGdj
         yqxuKQj6b5B4udaqOKwDJPVSpOOQ68hrKzMIO0Dbt+XmU2w8O1xfseEEhRXsQ9JtkWeB
         IFHCwGasW/KZG6jfkzc6xS/6g2UXkFet3YmN++/pZNTTeFt73Uldk3K9lzxJlCB0zm3w
         Jf4wtpgsM6b+anLsx0v6de7ATc3TarIgy8qHgU19Me7+4cNYCCqx2Eq5N5hqacvOlUdp
         iW0A==
X-Gm-Message-State: AOJu0Yynb+hLpmWGRdmGXCZgykCJ0ivj9VYRNaPgAUrVH81zhnID6yBJ
	s0sUDt0lCJBrJUQWcVcLufo33vgvJFXDGRnIru3T2Gf4DZfQEdtaFKJno7JUNeZ6MGY=
X-Gm-Gg: ASbGncvsLvucCTpr/hGE0y3D2ZlWswlepaw+TmgqbpOt4QBSrVONjU8Vbo4GHE4LwhR
	rxR0R2SBEmMB8xoV/UWNJhL/OLCb+ZIVZNl8qnZC1JLsGS7/y1FQCbNKjlQxbuJaVfsPKIhilT/
	QjJn4Ts1GItxMhSXb6Ei2h00Xjyj6/JUWhR7p+gwF3imiMwGlCJShkyugJCr96RmRNqJm8tEAoC
	uvzn8NOR+gQbHW/AsYMI6Z8R+UqgfCyzBOMOYp2YX+yGYJ5j5265xb3RKehs5aXT0iHibMG80Md
	t0ulJy0D766siogAc8Ip45CujlLHA5ob7XW/6eu3i12NHoSrdnifemj1jsKmJQ==
X-Google-Smtp-Source: AGHT+IE65xiXePmfkTNzrE3cu741b/HUQtQk5TEnp05EileMIiACkLUMMykov2/RQ02qlLbUlc+wEw==
X-Received: by 2002:a05:600c:1549:b0:450:d019:263 with SMTP id 5b1f17b1804b1-4538ee5d63emr156951575e9.18.1751294173517;
        Mon, 30 Jun 2025 07:36:13 -0700 (PDT)
Received: from zovi.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4064b1sm139691695e9.29.2025.06.30.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:36:13 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 4/5] tracing: Replace MAX_PARAM_PREFIX_LEN with MODULE_NAME_LEN
Date: Mon, 30 Jun 2025 16:32:35 +0200
Message-ID: <20250630143535.267745-5-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630143535.267745-1-petr.pavlu@suse.com>
References: <20250630143535.267745-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the MODULE_NAME_LEN definition in module_exists() to obtain the maximum
size of a module name, instead of using MAX_PARAM_PREFIX_LEN. The values
are the same but MODULE_NAME_LEN is more appropriate in this context.
MAX_PARAM_PREFIX_LEN was added in commit 730b69d22525 ("module: check
kernel param length at compile time, not runtime") only to break a circular
dependency between module.h and moduleparam.h, and should mostly be limited
to use in moduleparam.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---

As a side note, I suspect the function module_exists() would be better
replaced with !!find_module() + RCU locking, but that is a separate issue.

 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 95ae7c4e5835..b9da0c4661a0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10373,7 +10373,7 @@ bool module_exists(const char *module)
 {
 	/* All modules have the symbol __this_module */
 	static const char this_mod[] = "__this_module";
-	char modname[MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 2];
+	char modname[MODULE_NAME_LEN + sizeof(this_mod) + 2];
 	unsigned long val;
 	int n;
 
-- 
2.49.0

