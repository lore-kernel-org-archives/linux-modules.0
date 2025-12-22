Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21106319855
	for <linux-modules@vger.kernel.org>; Mon, 22 Dec 2025 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435099; cv=none; b=DKS6RVJr7fJr3QEbVRyF/nC1L4QjWloKfFtpEMb+eHPUsdUZ08pq4YtXZRIbNCXWDzdCt7K07loKOokxZXBSrvtdQXf7Zsc60On6GH6uGahwoPK+Lz/8KYsskt/lPpSZf6/bQeGu7JJQQYL90B1KMe22ABaAWGkMP6ylJbMonbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435099; c=relaxed/simple;
	bh=JEjLtrHxmAoMevZfx5zcGn3Dd09/WLycvX6Fodc8hm8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IrODA/JY+B22iKP7++RQc94IdFqohmuc+j0d4pCzQUJNwi6aHyZbU8wuNJUZwqiVRxzmxR3Ml0OZ925bF/OSubHt6jcwyCjVq6v5s0pZaHyvgy085sm/hMPssmVFbWT66IoX+1mBuuqyWZov2hbL36ZMPMho5gJPUa8DIK1cmmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0esBPSd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0esBPSd"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29f13989cd3so131452085ad.1
        for <linux-modules@vger.kernel.org>; Mon, 22 Dec 2025 12:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766435097; x=1767039897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYoSE4YgBLYmpgP8XQYWVedxsO90lAO2GWXhGQC1Zm4=;
        b=b0esBPSdeJ5kIMAJ+IwG+x5ouB1SLeXjq6pbtGtS2rZbDPK1WOkA+NIVUf21N7MvLJ
         9tI5c1poO4HOq9BwrDd9hJobLMaTLfC6tCV6NM3Hc3GtKY6g3PMo9Hvcnkp1IuL9C2L8
         IL53eiM78F6i73mbL1qVYKrcTa7ZvB4Jafeder7RlL9DiE/r0gIBG0RCLPYO1HHuls2D
         Rnz0F75rTCU/WLMovAuX49XW//s/WGb/yu35KOuXR477dUJnUBRHr79FZpzq0J0IsctL
         8naeIjx3aPqnjnwDmKDugrjqhxDRzmFH43djap5GZSy3iwlfGTbZKtNPzYQLAS/U+2dU
         Fcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766435097; x=1767039897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYoSE4YgBLYmpgP8XQYWVedxsO90lAO2GWXhGQC1Zm4=;
        b=V8JKVxz4kCNvMPS/+gWGvfHS21asYV82KuZSJYsOzX8aKC4rj30igmwWFtQF2x2DCi
         3CZe1ZtMAy6NkEHNgQ60MbPJLUUOHXF7NF9yd+/Nt7/AMzcZfruWi6r6vELVm5uOHHTv
         yp3/h7Ci9llfePjGt2Ljmxrx8o5EDSKYbnf0hE9V/4M+0DbrjpmGFTQr9dm6A8c5rIE4
         LvfWhz4exH4nCy8M9lvpOXbmu6p67nsFJ+QgghrBF8rFsJPdwX1q5SpHs0qABvEP7LTI
         y6K26bX3if1H9m/85uiqn2M55TyTn+y0E+YYXaP6iqCl/SOmR2U5/OKFuGmbLg9LncCY
         rftg==
X-Forwarded-Encrypted: i=1; AJvYcCUW8EzqcHQtpIT78O6kMhkgH4ycPCHxsnE3HqkzL1tT9F1Beb0kq3QsW0mTixdyuyLGTZ4GdzfTJ3BIBsKO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0qFPPjugy4lJ/yYaTBoxsjyXygafHLsh2QPG6WtpJi/63GcPb
	6xq1JMQtDKkF/NTOJrKjoBQwHapRLr7W7x9SZIMgIgLVDbkIf7BthjejKMn2m64ODu2qr5xgXs3
	3Wcbde67viDO3y8Wi/pv6hs87c6vjdQ==
X-Google-Smtp-Source: AGHT+IHV28QzNdnLrsYeRn003tpxtkC6nCRKD+KiIrMXMEtdI5RGX37qjBMaqmjdGXKeHyHlz4SE1+yqJ+s8+RqXJCI=
X-Received: from dlbur10.prod.google.com ([2002:a05:7022:ea4a:b0:119:49ca:6bae])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:458e:b0:119:e56b:c75b with SMTP id a92af1059eb24-121722e4529mr15037538c88.32.1766435097309;
 Mon, 22 Dec 2025 12:24:57 -0800 (PST)
Date: Mon, 22 Dec 2025 20:24:16 +0000
In-Reply-To: <20251111095049.67658-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111095049.67658-1-marco.crivellari@suse.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=664; i=samitolvanen@google.com;
 h=from:subject:message-id; bh=JEjLtrHxmAoMevZfx5zcGn3Dd09/WLycvX6Fodc8hm8=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJmeK75McFOa0GLgmuQ1x39mT9AZl/LjqZ1yEgLfCnzZ7
 eWdlnJ2lLIwiHExyIopsrR8Xb1193en1FefiyRg5rAygQxh4OIUgIn8TWFkmDHTQ6F5h5CG5/sH
 WbdMKta9MS288Sf0arya+nrprUv8Chn+Sk9/mPDN8F3IP49cb5/UyIze04Jsueuk2A4+Kp2SVeb HBgA=
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <176643400575.1902051.11698155532364546867.b4-ty@google.com>
Subject: Re: [PATCH v3] module: replace use of system_wq with system_dfl_wq
From: Sami Tolvanen <samitolvanen@google.com>
To: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	Marco Crivellari <marco.crivellari@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 11 Nov 2025 10:50:49 +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> 
> [...]

Applied to modules-next, thanks!

[1/1] module: replace use of system_wq with system_dfl_wq
      commit: 581ac2d4a58b81669cc6abf645a558bce5cf14ab

Best regards,

	Sami

