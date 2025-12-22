Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3501304BBF
	for <linux-modules@vger.kernel.org>; Mon, 22 Dec 2025 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435204; cv=none; b=JGKQkpeWbU9ZdDXUcw2qgxtpkNDTAWBo0B0jaSX78fyokTotgOuxsk2x1pwOYQMqhNtzx/Or/DUhL7Mmojd7w2sX0A/NwdsijnWdo2+Cv8WoOJbAs6I2dDkApu6l6Lkcv/D7ZOVZp4J/v8CuwDtd7ZKifjeqel74DjE+PF6sZ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435204; c=relaxed/simple;
	bh=RsQUM3q/RRAEvmm69bWmdagtGn+olCLUQewVCr6kzNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k/OpNQvruKs2Vy6dGS8gf47T6dAswWt9koMNwRfIe739f4o3YdXS0qJfL6Ex6mDMMrM3ZzFI/O00j7a5xggZXonc0DfWQovwpY2ABoZMC1hXvaCULU32yc7jSSPTh78yKem96d3y2yiLhXt2RvB75U3drUXaSruN+yHryU07prc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D18GxF5W; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D18GxF5W"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bc2a04abc5aso3833982a12.2
        for <linux-modules@vger.kernel.org>; Mon, 22 Dec 2025 12:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766435203; x=1767040003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ClXYARXyOJlMicERScavoSbvu/bTvHc91y9IQJo+VVQ=;
        b=D18GxF5WIOIgRW88r8SU0rAvvqHqa23QieDQolM349jGqD24Mbs9l94iW9RXRHdypT
         gGrk9m3t7khctAZAcXfw2W1hcwjlKmaJ7XbDTA0M16HSh7DOnIp0LhYZ8B3ZDBxDlzuw
         uNiWhdy+VMjY29nspxX8mjD59PBZ3z7LqBo3MXwLMe+EUGVirIgZymNLNidGsVbAaxKU
         d15R0jEZmDs72QEs4k9PTZelLYVQbhc8ZwqTrnHvMk6CHF5gEXpQAVWCiHdpePTSLO1l
         k3dHRQf58UuU1IznrKyYSAEQKm2aiicy2GF6zfqvZC9TJOjIvDqkOjgtIJkM2XtKIktq
         BNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766435203; x=1767040003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ClXYARXyOJlMicERScavoSbvu/bTvHc91y9IQJo+VVQ=;
        b=iuOes2gUFeuGnEl/JjKu3QQ4Zbe1z6HZVLV8PuS0uwZTV9QGO/QI4YpokTfRAdQfy7
         k7598tgJpLHuzcDpVlHuFNCA22s3mlnR+MKhMQH36OYnA4p1fR6eccus+Ib+zbGd+bYT
         qBYpbJrSe4O3GObY890CxBVUt2LR2xEOif5h7rSYVzttmltZnEhv1sKueb8r4+/dbd/h
         JlhP2TppYpdUNXMIu+dyy8ZmJKhVtRX4WOx9wvHlPTTil6juYNGVCGgrT37bd0bHm8lM
         QZ3t6YlEO+Rqcl/ehnGkE+873pS8EgU7J+Ut9mhztqa4dn1fW+5CeLLB9VJBHXnsD7I8
         ADiA==
X-Forwarded-Encrypted: i=1; AJvYcCWWkmwL2MuSsiaoG7T1xxnhHOeAhlteAgFUdSC029uICCWO5QoFGgDgVfGsKwyC7vGHVzSDfcOKOMFC2Nj4@vger.kernel.org
X-Gm-Message-State: AOJu0YxICku8HRTYCKZUS4jVaOHQsm22YUTml2BBALWXMViaofebAp6C
	AvrH+qATBM0M09iPD+GGDX70Kw6li+KbSG44Z2F3J1MJaEbbC8MKjnZZwJrSmQRQ76Pd3wFRc5D
	e148FQQ032htrO8M8KpCCUT4gNtRnIA==
X-Google-Smtp-Source: AGHT+IHKJ7fUny4DaHm/bK8/ehJv/3TCXxoKkzh1WY3i3b2NiYwqZG70WE84HurEaTRaFGCFRBmWtV5uuIPU1h6NCik=
X-Received: from dybkz5.prod.google.com ([2002:a05:7301:1a05:b0:2ae:5f89:cc45])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:7994:b0:2b0:59da:f794 with SMTP id 5a478bee46e88-2b05ec745ddmr10898676eec.24.1766435202968;
 Mon, 22 Dec 2025 12:26:42 -0800 (PST)
Date: Mon, 22 Dec 2025 20:26:37 +0000
In-Reply-To: <20251214202357.2208303-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251214202357.2208303-1-rdunlap@infradead.org>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=623; i=samitolvanen@google.com;
 h=from:subject:message-id; bh=RsQUM3q/RRAEvmm69bWmdagtGn+olCLUQewVCr6kzNg=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJmeK+s/XVe5t+jrbCb+wPp85+mvsianTz7eyDg1i//j2
 32hTP8lO0pZGMS4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBE7m5iZHgjmvRwdcFUmx3b
 sy/Exrp8sjNduYyti6vwvPy3+EI2nccM/4tCIj/z7HvpenLpymWce91XPrERaXpYIbDHeJnFuy8 W71kB
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <176643515673.1911150.6894435352894821226.b4-ty@google.com>
Subject: Re: [PATCH] modules: moduleparam.h: add kernel-doc comments
From: Sami Tolvanen <samitolvanen@google.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, 14 Dec 2025 12:23:57 -0800, Randy Dunlap wrote:
> Add missing kernel-doc comments to prevent kernel-doc warnings:
> 
> Warning: include/linux/moduleparam.h:364 function parameter 'arg' not
>  described in '__core_param_cb'
> Warning: include/linux/moduleparam.h:395 No description found for return
>  value of 'parameq'
> Warning: include/linux/moduleparam.h:405 No description found for return
>  value of 'parameqn'
> 
> [...]

Applied to modules-next, thanks!

[1/1] modules: moduleparam.h: fix kernel-doc comments
      commit: b68758e6f4307179247126b7641fa7ba7109c820

Best regards,

	Sami

