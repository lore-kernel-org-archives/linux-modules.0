Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679BF26F45F
	for <linux-modules@vger.kernel.org>; Tue,  1 Jul 2025 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389614; cv=none; b=eot0Y2+SE7Y+DfX3SIzo5ohqOp9YmiHw/YUGzSly+XtQEjK3zW2njsTicp3Xb/KokRFvVyefXKqrqKoH+m3S4sfUc04Qz8Z/HdrwhhNy2ukuN1cjNdvCaaUad3GZ7bGbEF+JoiOIg+kLZpADBEbAC5lVk4oSsaXyQFSVWhkWyIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389614; c=relaxed/simple;
	bh=WpjLH/E4cjfGcA5aVL0NX4+IgiTYP+bFhGzng+IGIMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpUj33nnRimD/bxTpzAEOZkvDn8xE6qL5PV7a6fP0RdWdl/Y1jNKzfQxfw04w+Jbkckf9kmTft+2HKcf5/Ya6eWNEkGXyT7+k7NzFFhh2qDxb1xRMKnSMiZFBtlycxEpxUZIgnXW5ZAR6Blhy4kia9xG0KtAjsit1Gg+T0ek6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QlzYJrh+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QlzYJrh+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-237f18108d2so235735ad.0
        for <linux-modules@vger.kernel.org>; Tue, 01 Jul 2025 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751389613; x=1751994413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RuV+zYZlBXFCb4jtObBSN/YWaKNaSZemTX8LVanYMvQ=;
        b=QlzYJrh+fZUfghsUEeLpz/OaWHx8XzqL6Uzlv4+voMGqBx6tst4zId8luAvNhP/XVO
         RIf/2an7ZxyqFyCIwpArc/BzS/6m6wm6+BKO7kv/vID3OXcIJGAG1q7I3KLtTvfLrsXA
         +YKH+a1IrqdHHzPbfNwYBKJ9DgMeis+o+3621tQi+fjl/b26iAQVvlpYg5DVsBXOtLqL
         rkezz0drkUKU4Yd/pyp5T0b35TU4qS/BSdWdHFOknb5YdwyVddvb0Ffl82i5QULqXbE5
         HWn1TM4i77zZiQnCDOecj/z+yM7BuPoWxefI5++3Zn3ZCejWCtU1fAMp7LM8l5teAoJv
         7YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751389613; x=1751994413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuV+zYZlBXFCb4jtObBSN/YWaKNaSZemTX8LVanYMvQ=;
        b=Yg+H4cOjF8OWPoGbtdd3wYtZYzWL6nCmGccHryqbnLyjxxYIu0q6pzxl8sUKNFwQoT
         rAAVXs15r+DsRWL/xUIDAPBgrJtiA4rwKKQXVkKXGaQzP5wxQv4V2Qc7n8Q2xiu4ChJR
         AqRIbft9GoCw2sPKjzTiUCFQRXR8BgIcCtSrkFM71magob1FXWHZOP/pVNVJQZhw5Jjo
         Ms1xxfneY2tbSCcshTO3xPZggi4oQVLfD6iYMlyj287JZr0tK0ogLmUK1lemrSxrtLkv
         Ha245wpmGgrn0au1ywsLkAtkLR5oTw55N9HhYCxMEVBl66RcS6ORz7VDtjXjn75AC9M8
         H73g==
X-Forwarded-Encrypted: i=1; AJvYcCXJW/1P3XD4hZn1tZ9tpe+TieQ8S95TlA9HY09jvg9FZULBgQxKS3s4jzrSlpQ/MeOPTQ/3OiAYWV7JHjLi@vger.kernel.org
X-Gm-Message-State: AOJu0YxesJweTtrckT5ROjMjFf25/z0huWkvB6kcBMDw+6I+y+5AsKO0
	6/zZ5oPXsVepxdFcvt1p6ccwNxtzzzSIboo33+k4AkvsKfPIN7uVQ8cYlPTH45J/rA==
X-Gm-Gg: ASbGncsS8xXwyUd//iwMvSK29zgp4UuQrw+cobHC7H6jao/9v2nloBKO84B47BsDHVL
	ZVUeBfcASWSh6HBlbRr1bvRN9Dr8bYBtN25vrKc6ZOjjNSWwyMzIgbM9gBKuQlRWGcXTkAs6saW
	sBk0nM9swdqWd8SNcKtpekbGsM3Sp9lh4dzFQjnJKqmOOqyE5A18D4IzyOcF03S410tePGY/Se8
	XbMHnwLCZln5cbTH5o2IfKd0vSg4M4f2YTTArV0diQburo8R2A9PhoC5lA9vzx1EIG2VCy4/QU+
	d4hTrWXZ7Li+vKY7MhHwGgAseY0vlwIEnSDhXnNF79ERV2EwQLRnVxN+5KKpT71k3bTDmsgkWw6
	yjoEIrcbYBHKeQ96f0niEWd0dwiIgsg==
X-Google-Smtp-Source: AGHT+IH3gvTNWjgUOSwEDk0Lnl1+DmC8Fu1pmwaP64IY32Oe1R+ZFxuAFpTFlieVchNMl10+qUaQLA==
X-Received: by 2002:a17:902:c407:b0:215:42a3:e844 with SMTP id d9443c01a7336-23c5ffbdd35mr3174365ad.17.1751389612305;
        Tue, 01 Jul 2025 10:06:52 -0700 (PDT)
Received: from google.com (106.81.125.34.bc.googleusercontent.com. [34.125.81.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e2423sm109764245ad.37.2025.07.01.10.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 10:06:51 -0700 (PDT)
Date: Tue, 1 Jul 2025 17:06:47 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Giuliano Procida <gprocida@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] gendwarfksyms: use preferred form of sizeof for
 allocation
Message-ID: <20250701170647.GA2234472@google.com>
References: <CAK7LNASzE1CtRo9T4byPXJtB-HtuWsGe=OLba+8JU9fB28Chow@mail.gmail.com>
 <20250701152000.2477659-1-gprocida@google.com>
 <20250701152000.2477659-2-gprocida@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701152000.2477659-2-gprocida@google.com>

On Tue, Jul 01, 2025 at 04:19:10PM +0100, Giuliano Procida wrote:
> The preferred form is to use the variable being allocated to, rather
> than explicitly supplying a type name which might become stale.
> 
> Also do this for memset.
> 
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Giuliano Procida <gprocida@google.com>

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
