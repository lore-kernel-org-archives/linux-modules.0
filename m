Return-Path: <linux-modules+bounces-1-linux-modules=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B13C0031C
	for <linux-modules@archiver.kernel.org>; Wed, 20 Sep 2023 16:58:42 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B1E2821B5
	for <linux-modules@archiver.kernel.org>; Wed, 20 Sep 2023 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377FC3E492;
	Wed, 20 Sep 2023 16:58:29 +0000 (UTC)
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7C79EE
	for <linux-modules@vger.kernel.org>; Wed, 20 Sep 2023 16:58:27 +0000 (UTC)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6862E99
	for <linux-modules@vger.kernel.org>; Wed, 20 Sep 2023 09:58:26 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-452951b27d0so16911137.2
        for <linux-modules@vger.kernel.org>; Wed, 20 Sep 2023 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695229105; x=1695833905; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i6XY8wIMD7LjGNpegRcCUKrZA0w1gq5GxQRY7mj2AIc=;
        b=JHCEsj0slvkCodIClcvq3aIDOKwvZ1fi/kcCbNR/eo7xlzzL2pmxNYu9XNJwTRqx6n
         4Ony5zAr6E1Kidp/2L0SnyepxnRRsRbKSN8Rd9+WW5dhz8Sswa0wdZQiHQb9P/lFNoDk
         gIhWGlJ17jaCuSXZaGXMjREdzGABuu4n5x2sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695229105; x=1695833905;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6XY8wIMD7LjGNpegRcCUKrZA0w1gq5GxQRY7mj2AIc=;
        b=uf5P0QB4Zlts0gV7Wlpa4SOBCsdnM+hE2PoSp0IOTk/cHqtnC2q/wsVPEx3s71Ijao
         93DdHE5p3hJuKf+jVHwmjKceQVUJ29gaD4Pp4TVgDYVY8+Qa4a/nQOxYGmFIgv5JWWxF
         yu8Je1Cd0mND7z+Y+x+NEHIraK/8U2R0XuKGjzKo3R0CHOmUiJJnp3dy0z0ESuYUJWQW
         Qw2GeQcn4vn/p64+a4jJy7GU7SJ1C+l7Q4CuewvNMEqufLmsDz9bhENYNvoGxfWMkAlK
         Vw34Hp4CpRGaZQw/LBrVe+dEPbokznSWEDOE8+dZGUgrUFjcpIqIHYgSWMF1ejIvJig6
         xpow==
X-Gm-Message-State: AOJu0Yz2wWOc0qkIAlvgoGzsFZ9xjLDm3Swuu4+Uj/ssElTdte4lizKQ
	WW0J3qQCiCNHivaqLJ7QDpFQqeS2bSuYL7hV7s0=
X-Google-Smtp-Source: AGHT+IE8nNdFdE2yJvasDrq+V1ZQHQWvDG2QxM9MRv+eWF9dqc1p+T4ITL4rc64GCOsg5TemuQGGhg==
X-Received: by 2002:a67:f50f:0:b0:452:84fd:4a0a with SMTP id u15-20020a67f50f000000b0045284fd4a0amr2458979vsn.17.1695229105345;
        Wed, 20 Sep 2023 09:58:25 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-110.dsl.bell.ca. [209.226.106.110])
        by smtp.gmail.com with ESMTPSA id b29-20020a0cb3dd000000b0064f523836fdsm5436411qvf.123.2023.09.20.09.58.24
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:58:24 -0700 (PDT)
Date: Wed, 20 Sep 2023 12:58:23 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-modules@vger.kernel.org
Subject: This list is being migrated to the new infrastructure
Message-ID: <20230920-mural-oblivious-e8d0ae@meerkat>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list is being migrated to the new vger infrastructure. This should be a
fully transparent process and you don't need to change anything about how you
participate with the list or how you receive mail.

There will be a brief 20-minute delay with archives on lore.kernel.org. I will
follow up once the archive migration has been completed.

Best regards,
Konstantin

