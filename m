Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A3304BBF
	for <linux-modules@vger.kernel.org>; Mon, 22 Dec 2025 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435096; cv=none; b=WFEspIrci6Gx80N3AiHpfFf5xa5NCNyPjDCApgPjBly5izJ9HQUpqpqFydmCdNlyJSAKmrsaJjpXbPUu2p8i2qXJ7FlvETzJ6RCMdOOgpnKbC5H7zqZRP4h6Vi/ZNoyioNVDesffsRNB4lQ8Ho6gT8mPTnowyFkR/9YgDNxj2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435096; c=relaxed/simple;
	bh=9rd+GpwzLc1w9cmaB5ydQoPGRQPj7ozHx/DAQZ4dYr4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iHUdyltEiG1Csiy9C9yvUfy0CvcA0sXvdFmq+3Emlyt6a+6iMBi0hCHdgTvE/wlB0Js7elMT94X9pVZQgLatwcvM1I70Oo9cfE3LNbOnYQoG20sw53I6owGEuwvxcNPnPRyOt5kjCfrwi6uq97dU7+31INjxOMvhPEaOe/CfTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4X8kuzj0; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4X8kuzj0"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34c64cd48a8so9828102a91.0
        for <linux-modules@vger.kernel.org>; Mon, 22 Dec 2025 12:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766435094; x=1767039894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fdi1SM/nAbM7Pof3bvt+6WkayM59q8Xfd87dshQVa90=;
        b=4X8kuzj041k1HMS43Xu9ssbk+iDK1SdzF4u7anEgJdXmY20zHpclegwMrhFnkAOTI2
         tTDNeL7ucsK2LTiKlC9WAGr11pNJlNhS8ex4SbQW6ygXDHeSKoMbfFtG4D494va2E1gF
         HWOxOwv04bQwuY407MPgs6SsZDFJY0+hrMN1Gxb92qIbgVUn0bk63mHUFvvSQFSK8QP/
         br4debh6MoAezq2VvJiivQqkRfsW7Hl1ej06A2iebY1bErH5I6iA8lJmlbVq6R2LmK87
         zMXyBytlS+RFV/5vxmgCDONpaRl+cxtuHz3ntGyA5I8XI/PRjz7wIAyr535Km/P/m7YR
         0Lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766435094; x=1767039894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fdi1SM/nAbM7Pof3bvt+6WkayM59q8Xfd87dshQVa90=;
        b=E98E0dkKaQg+lHN0+fHlPABSFiSqpuUA6s9zAf4/grfLFucB+HSKST6ZVaxxQTEPbR
         lgIg2LyrsNpTlEbYM86GtWBZVnM5kedU/QC7Py/kT3KqhxGxTrf9y8S+JsIrbwsTw5Ee
         G1e6G4CRTn75fH7DBlQ1LQ9P/BuSLYsEZQ2vJFEI0g51QkWRI+EoozfDdSVikmBsXF5d
         +KnN9yA333IJor4yi0XOGjeP6eydTr9i5fKB/N6yY0t3ozbmJjwwK9DZbtFZig21SVtG
         WDJdAAvtwP+6vZBJhFdS85EyHFHkztAhp2Tkh8tog0qWh3IO6odMxMrxIhrm5dcEL+NL
         Y7AA==
X-Gm-Message-State: AOJu0YyijKabiQKBd6SpT7Sic37F/BB596a8QStBYt+RbSyS/jjM7iKt
	BkQC29UKQXuJI7IqRnqtu3etjvHCnHohWB/nY16pBkC7aIhAHL2/tYDn1oiF93yrxq2zYoINP3A
	cgFW1pxA5vA5N5I6SngE3bpCBnFyf0h8klIRJUc+B7x6OqqpdDisxB0H4+xFtN71eGcuZTQ4nyw
	hm/RDqyYJgqtaz/ft1Zsv/gh4En4YRM+BQnRKUKFgPASgLJvCOFCZs6a6ppd5iSIhY+VcH9tU34
	Zn9Vg==
X-Google-Smtp-Source: AGHT+IGoq1CIOLiUHphOY1xkNyX6Xae168VYvdK7hs6guIsiY2W6mU5hTHiY95SH08FqYdtKbrgKNNqEH3qSoLSsGto=
X-Received: from dlbvv19.prod.google.com ([2002:a05:7022:5f13:b0:11d:cf4c:62ab])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:e13:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-121722eb801mr13420034c88.26.1766435094054;
 Mon, 22 Dec 2025 12:24:54 -0800 (PST)
Date: Mon, 22 Dec 2025 20:24:14 +0000
In-Reply-To: <20251201030606.2295399-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031080949.2001716-1-coxu@redhat.com> <20251201030606.2295399-1-coxu@redhat.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=samitolvanen@google.com;
 h=from:subject:message-id; bh=9rd+GpwzLc1w9cmaB5ydQoPGRQPj7ozHx/DAQZ4dYr4=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJmeKz7/TUuY2STVcmh/95Lap9O1J30SM4x+M9PIOXOvN
 uPvE46HO0pZGMS4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBE7r5nZDgZNNfy3uX0nI7p
 fpdMRcSz7gfnlsRtPckr+/iCelakWALDX9mzntH7zLbJLSlYp8DFIeYRxzA9LKm0t59hYnvZ25d /+AA=
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <176643400584.1902051.10979216909918913544.b4-ty@google.com>
Subject: Re: [PATCH v2] module: Only declare set_module_sig_enforced when CONFIG_MODULE_SIG=y
From: Sami Tolvanen <samitolvanen@google.com>
To: linux-modules@vger.kernel.org, Coiby Xu <coxu@redhat.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, linux-integrity@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Aaron Tomlin <atomlin@atomlin.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 01 Dec 2025 11:06:05 +0800, Coiby Xu wrote:
> Currently if set_module_sig_enforced is called with CONFIG_MODULE_SIG=n
> e.g. [1], it can lead to a linking error,
> 
>     ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
>     security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'
> 
> This happens because the actual implementation of
> set_module_sig_enforced comes from CONFIG_MODULE_SIG but both the
> function declaration and the empty stub definition are tied to
> CONFIG_MODULES.
> 
> [...]

Applied to modules-next, thanks!

[1/1] module: Only declare set_module_sig_enforced when CONFIG_MODULE_SIG=y
      commit: 1ae719a43b0336678172b3eb55c5187816f9a130

Best regards,

	Sami

