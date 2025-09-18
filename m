Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC1631AF00
	for <linux-modules@vger.kernel.org>; Thu, 18 Sep 2025 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226302; cv=none; b=idScjRpE/XiqHkMqLItwjFQbLSO1V74RMFzIwooXBzVxEpEz1oIN7Z5oydRhe+D/aBvuVyuLNMte5PTduKVXbQYIUUxG7yAhwOkiqUK9fpRL9UXDWSl+6XBMdr49Q/Po81+a2dq/3srfiNVtWNGZmt7PPBnsCgJqiLIibzkzGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226302; c=relaxed/simple;
	bh=MlzkbCzxBnkF0Ot5onCFMHUEUOT6VSHs/kNPIgP/+S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTr/0HEhtn/HrJOlRJaF/XJ2TxQKImPuCnC+dDZZ5qaZJLipUDlFXVBVmtNvl/IFbWYquULn2zH3lbaJawb/225MUoEIPtihKAAoI9HwFzAItf/I1RTPLL4wf3Y01ujQokhVKVlHt3wZQYMzzhOuGLh05hVoMtQbnoNIzZk6C9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM02LC/a; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM02LC/a"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b58b1b17d7so14882241cf.1
        for <linux-modules@vger.kernel.org>; Thu, 18 Sep 2025 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758226300; x=1758831100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhfQTSFAJZS9gqyA7ko5YffZgh1O242sf4VUlqQppZ0=;
        b=eM02LC/axWmr3jPeOA08ELiKDGqjZNpRcV7k4H1oFtooYPItDtxlLJSuKSh0lhQO8D
         llHgYBMJ9TejkpkYA3Pct7MQJ3hzDoPczGJorm0zPCfQ/adUAhiFxdjbeMBPsRcUHvMe
         hs0sKRJOfdbuOQTzemhZQmnRQJZQ4ZwQvpxS8t9a8GU+tFTUinhbpIiRSK7lbtoZTmI/
         xDdP0KXWjjZUeVMmYWj14L6oPRXRyMWYKl96x3ObZYgFqfIkY6wARZhFSLkMKvKuey/i
         dW6X2FsFQrR6mGQWm3bj6ubypfH5BS30WRMo/+RGAxABobih94f+7Jd3WCWOUmVF3ROD
         6qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758226300; x=1758831100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhfQTSFAJZS9gqyA7ko5YffZgh1O242sf4VUlqQppZ0=;
        b=AZsmPJ9qvCs33WMZG/xorUw8HoR5c8/4pANWIisj1roMGhjrEbsyLVGujoFAgxvFj+
         mQw26H2qhPrW9hr9XUJ1IqXD5FOqsJvYR/VLL+1EN9clzLLCr3i8zFHasxIMZJQkeOp+
         4PrUg9rh43IuU3IW/yCMSosglnmQoUC6Iq0SWC0Rfte9jo5dOaFets90PABysKfkl+6l
         Fab3jAa+vvk1dmDE13NPR+NTgbl/r/LOPOrgLRxS3Q6AhSmFQjD7+UymPrAkgyzEXtCs
         b7nV9OCDyyvPBpzgFoS0/UP71vhpjRsN3KVBhuHYuI//FhrWwbmfGQuOhGABWldZa1ws
         3nHw==
X-Forwarded-Encrypted: i=1; AJvYcCVvw4gD0rC49W9GwHcSHdNxAj8Hrep55tayrnw9eh7zUkaoonxLsCj1PahuxGEXd0KdBUavIXQXo0f5Dz5V@vger.kernel.org
X-Gm-Message-State: AOJu0YxOzt14ALeeCQLAewjiIb45BbVt9xYN9psJea+6bAFkf/Sa6bc0
	FaK40HTNTnoBIo3nhOxCvc2dCHqNTeavfYRW9sqXKZwGklVOu4mXvljq
X-Gm-Gg: ASbGncvKm5R0AcTUn7m5oe30VU+qASunnr5ZSPtq+aMwGk+kL7/VdP4BTijoqdTerQ2
	NUTCcp9Wo/k4h0ZYL6wF55a4UXAYsQM6cp6l1JgIwk255+QK+7y9cN86gSUstXC5RF59I6Gnovx
	KjiMUHwG3XHqlJuSVd0bxcVXmz/4iArotkwR8Aq7oWbgadq6TWvheyyReABA3cgrmZW0q8491dR
	4KMmywJc6/g/Q/1YC2yt3Zy5lQbGsFDFgcf+/sGVygRsCUCjKfZ8qcGtlG9uVPqA99oBpInk/+0
	ewTxXjdqDOWKqu42F8E6S7+DLp0tbps6LYQ8Z3ZoV7QT5L2Q/EDBwSWxA6sZ4xMGgUtAyb1Ydeo
	elXQ9p+RNk9Flis765r3l7D+TNlrosU3xYGZHQVgychJs
X-Google-Smtp-Source: AGHT+IH78xMwfYsunN2DfRqB0zpQ4ad+WkU0hv4qihFufyAmnZbwnOXpnB024qM+pbW7ssyAVZOIjQ==
X-Received: by 2002:a05:622a:1892:b0:4b7:acab:852b with SMTP id d75a77b69052e-4bdad82345amr55746341cf.26.1758226299961;
        Thu, 18 Sep 2025 13:11:39 -0700 (PDT)
Received: from jl.umd.edu ([129.2.89.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630299579sm222392985a.41.2025.09.18.13.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:11:39 -0700 (PDT)
From: julian-lagattuta <julian.lagattuta@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julian-lagattuta <julian.lagattuta@gmail.com>
Subject: [PATCH 1/6] module: store init_pid and idempotent in module
Date: Thu, 18 Sep 2025 16:11:06 -0400
Message-ID: <20250918201109.24620-4-julian.lagattuta@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918201109.24620-2-julian.lagattuta@gmail.com>
References: <20250918201109.24620-2-julian.lagattuta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: julian-lagattuta <julian.lagattuta@gmail.com>
---
 include/linux/module.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 5faa1fb1f4b4..5ac5f4992fe8 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -599,6 +599,10 @@ struct module {
 #ifdef CONFIG_DYNAMIC_DEBUG_CORE
 	struct _ddebug_info dyndbg_info;
 #endif
+#ifdef CONFIG_MODULE_FORCE_UNLOAD
+	struct pid *init_pid;
+	struct idempotent *idempotent;
+#endif
 } ____cacheline_aligned __randomize_layout;
 #ifndef MODULE_ARCH_INIT
 #define MODULE_ARCH_INIT {}
-- 
2.45.2

