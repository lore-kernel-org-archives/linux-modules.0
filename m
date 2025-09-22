Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2D3311940
	for <linux-modules@vger.kernel.org>; Mon, 22 Sep 2025 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758566923; cv=none; b=sTq9Am8fPhSdClWR0zRZUOIT3ewCJ93GZanwRfDTKjgSvPJh6fqdjTpV5aJxFnNOQue54ThCNhKLWByKg6dJiwPU5y2yAII63imuYBwqcDlRey1MJWKzE9DNHr8rxY2yybW6s5WY7a3jdwMvntlc5gy1/IghCr3ezGLHer57ATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758566923; c=relaxed/simple;
	bh=62BWT+ChZietzG21mZwYd1nPiVzg6h9wIs2Www+JfAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7RyhGODTLWJxYGebZ69p2h0UoKuaqeVYS4cFh2Zk1CZVn0yJ7sHnN+Og+fKfyToIFcGEr8aR3H/FH4kKR+K4z5dxky8fRYcuRk84PxQLjMYJrzS0e9rI9ns6iqYJofs+TNAMLsswnwRDt98X33Ocqwsc+bRANvPDfcMvUpMLUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EMZMCUwR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EMZMCUwR"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77e87003967so1658333b3a.1
        for <linux-modules@vger.kernel.org>; Mon, 22 Sep 2025 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758566921; x=1759171721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62BWT+ChZietzG21mZwYd1nPiVzg6h9wIs2Www+JfAc=;
        b=EMZMCUwRqkqCT7w8Zq8rDm4OrkZdVUjuWagkuWRFgsBEcR4H0ab3y255zQb8kv+8Ku
         mI6iIbZXgUt/HcTQtAXojjSmTFH5pEDAV/unjNJ1AQbxdtTAvt5gWZ0uF+8Qll98vd/v
         CUyzL9+3Z/ozswqE+LwhUbfGoUUkQLfUckDx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758566921; x=1759171721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62BWT+ChZietzG21mZwYd1nPiVzg6h9wIs2Www+JfAc=;
        b=jb1v0U5AeIdqirHxi9mwuZJS5UUgR/Ux4ldoJlegVa0JwYUP1vT2atISy9J9DDx43Z
         CI88Zjwuy/QQsZYv9/gWTruolDtOyjPs4Af8dw5JJYHglXX3Z8MEl87hD6ljf7lL0WsQ
         dseSOoJtqLpqj6fvRBlZe94xsTf+89WMNMBVtNQKl/0UV/4Cl6E/T3CtxvTjWmdY7eWf
         LJlxzRNCYHA2DSpC3izmXwwyIKytG9i0ah4VbYZtN1BA98qmoHo78OWUcgXOS7vXPn32
         ZPB5OYDSHCQbvlTwjCcRmcuFOZyCvYWAEaC7F58zebYV+JFmzEtF4iigBYeJMHqW53KF
         Treg==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZanCPO5Q36xE/ORzm+Pt0d7A+0ZUsxXpj4cPazc3Fopu3lhY7T0RaO5c/kUlDmF9xU+ghZjb1yPEvqkN@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNpQyGVZcyGi0iKMbV5GgJU7EyawdTCIT9rpitP3B/Pi2hkuc
	nKP5pgv7mQ9Cb3wym1sCvfdbuHuMyPow28KCMrwmytrHzyHggRJg6ijoMV4Wsv17rCQCK7s/BRM
	gAYo=
X-Gm-Gg: ASbGnctK1yB5Im1xiCDK9hv/4jZGitPPluzjsM/xQ3tC7C7Gs/RZcEAV7eHTJUwgKyS
	8nW63PCUNd66517V/SUmFqqVi9accKWkSXsYd97qTPA9sctkZ+k/dnEbgWkixxiBrKE25NDtg06
	+4uXVJ7j74I45nBmvtBq1qiFv+3kZ5F4ptAdTeYzoGH4TGJtgTd6urqxafRVTSMQIjhrTBaVuUs
	mWoforq13pMSeaHb/imWzeKTUyEpOi8P5eoJ0LzkVcjWu0st/GNbVuThJvEBcPKy+w6brm2OVHd
	7WaeKJ+5kkkb/JQWus8AkESolyXgV1aa+LIyhoWTO1yCDQ03aHE3BN/ggm02kCb0aB3cbClqfCr
	1AH1jVTxVThIV3mT0sVxBOgjLjREI9WiaNKgcqq/l4jzxBp96AMNSroBtoGyM
X-Google-Smtp-Source: AGHT+IEwQZB9OJP+yIk47lHkNRnpblDU+mAiC3pniWHHE9+nReBcI884SHHQG9F+tJn/QrVZqfu7fA==
X-Received: by 2002:a05:6a00:390b:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-77e4cd35838mr16708833b3a.4.1758566921098;
        Mon, 22 Sep 2025 11:48:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f126:ac9b:b8ac:e280])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77f34d416a9sm4169794b3a.101.2025.09.22.11.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 11:48:40 -0700 (PDT)
Date: Mon, 22 Sep 2025 11:48:38 -0700
From: Brian Norris <briannorris@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: Add support and tests for FIXUP quirks in
 modules
Message-ID: <aNGaBiUOb6_n8w8P@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <aMgZJgU7p57KC0DL@infradead.org>
 <aMhd4REssOE-AlYw@google.com>
 <aNGR0x185VGHxSde@infradead.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNGR0x185VGHxSde@infradead.org>

On Mon, Sep 22, 2025 at 11:13:39AM -0700, Christoph Hellwig wrote:
> Controller drivers are a special case I guess, but I'd rather still
> not open it up to any random driver.

I don't really see why this particular thing should develop restrictions
beyond "can it work in modules?", but if you have an idea for how to do
that reasonably, my ears are open.

> When did we allow modular
> controller drivers anyway?

An approximate count:

$ git grep tristate ./drivers/pci/controller/ | wc -l
39

There's been a steady trickle of module-related changes over the years.
And several modular controller drivers predate the
drivers/pci/controller/ creation in 2018 at commit 6e0832fa432e ("PCI:
Collect all native drivers under drivers/pci/controller/").

> That feels like a somewhat bad idea, too.

Any particular reason behind that feeling? Most other bus frameworks I'm
familiar with support modular drivers.

Brian
