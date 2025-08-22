Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEE12FFDE5;
	Fri, 22 Aug 2025 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867318; cv=none; b=Mt4yrTgls/8i4plekNed+bGW6xCEK7H7/qcFlINhHY2nAhnxdHc7m26ETCAuUwVGYrK2ld0wJrGY+wjrCXHC6hqtxFlRSwXfEg8v/0/v5GjteVv/fArVAPwY0snxBz/GO9xdd0WL4hasmY6W/Y57V1UwkIsfLISw3xuqI8bkQYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867318; c=relaxed/simple;
	bh=AZOnz1zlxPtwzPyzKyQtxKUFGb8zoqUHrxPJKGoTOfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOXNJ8Z47gaGpWAiygdoT+cMOqrxxXXc/cykpP70kbt8IEUhF56xiVbI1H9mk1NXaLX2TLyp+HG+EvvX0+va92ZUhih1CR8K2/f7Zch8DBaZq5fyn9bwiIFYvCwHThXHYDtCoiV+8Adh58tFzXXZ+zrh/rs5C7oewpCo8PgPDJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTEY8tni; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTEY8tni"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2461864f7f8so13975525ad.2;
        Fri, 22 Aug 2025 05:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755867317; x=1756472117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MOC5/63BtcNhL7vYKgaSAFKz3pzzEdi036Le9lmLW0=;
        b=dTEY8tnis4flnrxCvTdaer/uByh8Fo708txFes0sMEySPdGCWjnW7SVsBjvO3n2gN6
         E9KXRNSCCIoZrINw7Y4PP9aPJUCwjQvhhxd8mK/TBUymJ+PIej7di0cHFYJc0zmizVrP
         EIG6BtgXDMOJwi49SAWmkRRSCm5u7tPGUqWaI+sqSfo2pqfP4HY8DZLttcA2Jpj3dP6Z
         PFVHvmrG06RyLToUQXcLmrh4yYlBjZWFmoyuy3CSVzPAHdK5+3Fy6WjNTupXy8Qbg6oc
         RugATgpMOT3g4jc1QBDwUflyFzY3Bn8rfsRxfwNM2EN2TzSKKqGmtA6usFsCFVuo5X91
         FFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867317; x=1756472117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MOC5/63BtcNhL7vYKgaSAFKz3pzzEdi036Le9lmLW0=;
        b=xQEl7Rq7XyOgcQPPZhagEsHdjjal4FUnHxRmiiQFMIa9/7Q0FkwdWqMzDnodwdgpIr
         9jL4/ibnMIyj0keevtLppt4AFM5gLHZ7taKEK4iMZ723bi85wFVpSjsTnTdnbS28JJVP
         w88Mtl+LTSquuEgIPUtXW+y8pdYjQe/3HJpE2d1u5DtzA7DfmUJ+wnyIUF0xaRUhk5aE
         Ksx67j+xmAkJBEzgOoZm1I6n38guyFPIxuw/V7K2Zh4odSxVxVoNkz+OUK26IKkE1OOC
         3tOFzExSk81WoszdK070/RmwXC+utz1m+CDOz6/QM+zg0JbYuL5PW9L89wNDGKppuOsX
         Jdcg==
X-Forwarded-Encrypted: i=1; AJvYcCU0y+mziB1J68u5JNBw7GYM5PLZZOAmkvDFN3If0peMYaOzTsXAEP9OBpG2FzTJJ0klMlYAHoFIRj41FR4=@vger.kernel.org, AJvYcCWfbE+sbK5X3CkkJC5uy1DgRhT/rPxvh69wkMK5Gk5HAhRqkPvBV75W1jcT48b7Zt7okdEtTUHgyAu8JwMCsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMsnQ4AWFS+VYjUuHbOYOdboPaq30tkm0y6F5BeQ42haTlsLXy
	lhJnrGvMjZf2l5yEeK/+wz+KxOouj1k6pGUpjcgJKp5H4bpAym2hxeVB
X-Gm-Gg: ASbGncvDlyFs5FJOmJoadnMhghkn7JogemSkDePBhUg+NE7I7NMauHB+E0b19QiFPbd
	9MzwxVxztlpj3EL+vvMzjWteGmF8H7vNI7ew/L6ocmakrktcEzEbdXvuWtzwB+7IMKVFFOTxetj
	BSH3fiVO04N3DzjsfPb9omncjkq7gFGxvXm75xCr/BrYOewHllrZ/U5/er8NfDTZrytHIuU240a
	E3SrvAYt/t4Hkf4yL1SQCYDVAlYGtauhz+lACyyJwA7xbfyHq5PSxbS0GPlJFuW7zNBB/JsLOsN
	S66dvH4r4JSGgxjC0yE7aIRw7lPD7bURnPq+ULvsT3AI0YgRMNxObJQjx4tvdsY/sMC0TuUlEaY
	bDT3Hj3X9tnFF3USyPoFQMh3TMGL/veH4hXJSx0BnfAc1TUkQifxcdvtvIwt+UC068ZwP7wy21E
	k=
X-Google-Smtp-Source: AGHT+IHunU137mEbBlLdIHFX75ERCXzYfs9Y2SkuVa1UjA83/OvrvhnUZlihpUd+AXWeWqWH7vic2g==
X-Received: by 2002:a17:902:ceca:b0:242:a0b0:3c39 with SMTP id d9443c01a7336-2462efbd88emr51869585ad.54.1755867316671;
        Fri, 22 Aug 2025 05:55:16 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed377843sm83617285ad.57.2025.08.22.05.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:55:16 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 2/5] module: signing: Use pr_err for signature rejection
Date: Fri, 22 Aug 2025 20:54:51 +0800
Message-ID: <20250822125454.1287066-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822125454.1287066-1-wangjinchao600@gmail.com>
References: <20250822125454.1287066-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make module signature rejection messages more visible by using pr_err
instead of pr_notice.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/module/signing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 9e24c79499de..00f079cafd4f 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -112,7 +112,7 @@ int module_sig_check(struct load_info *info, int flags)
 	}
 
 	if (is_module_sig_enforced()) {
-		pr_notice("Loading of %s is rejected\n", reason);
+		pr_err("Loading of %s is rejected\n", reason);
 		return -EKEYREJECTED;
 	}
 
-- 
2.43.0

