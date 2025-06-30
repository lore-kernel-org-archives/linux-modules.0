Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567E28C2C7
	for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294176; cv=none; b=Lx5CXFY7MMOKv1n0vD/jiXXPEmd10gdMQplot83YgW3jvkUlmOlIYqXdvkzlbxelqQFEMlAUKGkEHaA0ePyvaJ6D2eHXElKVuRu+BbSAdzPKB21evXZFB4O69O3PuIISFxjtG6nfMcgpOCT1hsR7ZbSkySubGY92Mgw7rC6nFZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294176; c=relaxed/simple;
	bh=GcqUSQ1qcmz/7ZeeKmvY5jkflwUDRB3NFv+8GdhdPdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MydtOO03YBsMOx9tsq8HHusiilNGhQRfCPZxLfliDvVxi5YEMCZEmLA988jC407VF2p9uIjVPR97j5UFhHgDcFgxGtDwNvouCgHJMTtHWA9DvbXbzEWz14RogLcxcjGxzdKsnhqdQ41pBaJqgLPnB8jovt3nUQFzbMxUndk4AuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aRzpc+sx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aRzpc+sx"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so25940225e9.2
        for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751294172; x=1751898972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdmllR+tX3Z721QiQkxJd2Ok2zA1l/euwA16MKRoano=;
        b=aRzpc+sxo8QYXVYsSFsuJtsXBTlWUpVL/rXRnLqwbgEWzd97vPf8b+Si9nmDXDIyPK
         XTD+APbrcDs5cImjTcEIcCIqwBroI1cu6RJzymGZvi5LF3Q95Us2xGM8+eh4RXvU5D/C
         Raqg2VFtDUIlUb0eeh6f5LNdue1At00QxBubI9xGQ7fEYj4PDVZVbISbAFrKfGSP9XGB
         QfKrSmh/MhJESFcqkO6tYAvUefssPU24PtZIY+1eO8J/AV4qDyM8EVjIl4PTptKlVj8y
         upzqEi+jN/NOgViCGjyTlSKDHR6bSZZ2JPbzIAvgIKFrxiPL+HIvy7kQrDWXCGKnN8tZ
         VcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294172; x=1751898972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdmllR+tX3Z721QiQkxJd2Ok2zA1l/euwA16MKRoano=;
        b=Srpfwx/jRNFGxihIl7Sq5LM2CU7uCbtVr6EcZ/OUoxxAhw0CIOZO3N0SjSK6dhrc9A
         +L6o2jA4Hxn43OdaMlqmPrSo2a8l/crbJ1l/Z9q2KRSgUStirTiRFsAZhvejB8dBdC3V
         CSN8yZNtPnaCNIl7bztVhq+yLuM0U2QrQEpFQXJwyrwQ8UT6j89Ll/FaOZALVc0s7tTc
         ZDV6UwhlLPcFgFOXdYc2DaFPVllMB0TakehAHmxm+w3RLwhlZ9enPDOD5oWnbKLtR5lc
         794KxqvdVHjORYmPAQ4uVNrw4kfgNxikggoC7o+470gSmwbq3Ng5f6LdiHuG4ShQdzHg
         axyA==
X-Gm-Message-State: AOJu0YwQ7q2d6UG/GjWTvxTnx+XRc4t+ubDvwm5Lqt0KLT+6lh5/KB/U
	3nNUn3rAQlYQe0KJP+QaEvAstUy7EIVyMKIPBtWlH5id9fUhY2icTJriFmp0XVjemfo=
X-Gm-Gg: ASbGncuWnaTw23hKva5o1Ylm09V2K5e1B8yE1PVbOOiOHwtMd/04RgrQ72Dg+73vXxt
	ofVmtM5m4T65RaWfch1vUX3oICkkMtIvWJJqdpMjcLM0NNGaOacVsh6hLNNHloU38U0eC4tDdub
	AmrOG4IVpblnzcuAp5GTOdv+TaR8raaSm2bRC2R8Jx+ahobX+LepQmEbw6e3pgOdLtQY7xsHfFK
	L8BxBsWTBTmgaUA2eN738PB2i0Q6RRGCaONPoJfHsTycOCKgZyKy0eByIGV5rEIn1CvUB32Hvl4
	ggFE1FOhKQ5FLGtfjaTpEeKo9rXaAAWmmmLZt98io8W+7wl7nMYAKNjXGvky6g==
X-Google-Smtp-Source: AGHT+IHplNB2XhqH2vF81/rVmM2u2fb85B4S67wVN0ofQUkT3FQ10OfKl5FvFxECzW46dMrxe1/+2A==
X-Received: by 2002:a05:600c:1d28:b0:453:cd0:903c with SMTP id 5b1f17b1804b1-4538fd62fa8mr149537915e9.2.1751294172350;
        Mon, 30 Jun 2025 07:36:12 -0700 (PDT)
Received: from zovi.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4064b1sm139691695e9.29.2025.06.30.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:36:12 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] module: Remove unnecessary +1 from last_unloaded_module::name size
Date: Mon, 30 Jun 2025 16:32:33 +0200
Message-ID: <20250630143535.267745-3-petr.pavlu@suse.com>
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

The variable last_unloaded_module::name tracks the name of the last
unloaded module. It is a string copy of module::name, which is
MODULE_NAME_LEN bytes in size and includes the NUL terminator. Therefore,
the size of last_unloaded_module::name can also be just MODULE_NAME_LEN,
without the need for an extra byte.

Fixes: e14af7eeb47e ("debug: track and print last unloaded module in the oops trace")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 933a9854cb7d..04173543639c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -580,7 +580,7 @@ MODINFO_ATTR(version);
 MODINFO_ATTR(srcversion);
 
 static struct {
-	char name[MODULE_NAME_LEN + 1];
+	char name[MODULE_NAME_LEN];
 	char taints[MODULE_FLAGS_BUF_SIZE];
 } last_unloaded_module;
 
-- 
2.49.0

