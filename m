Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459136213F
	for <linux-modules@vger.kernel.org>; Tue, 20 Jan 2026 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950973; cv=none; b=lU8kgWt9Yq5+fwtrhkNt8tap1WLJsYfcVxrxwsqcDkLm1e4UWCvLQofX8tyweKMBG1VXjor+WMvVhibtETs8pQH4UVIMu/wGX6dtXoSYRe52TizbcaquzszUlZYIx8LoexEF8FMIvZZOCsztypUcCYaHRGaZErC+Rl+/ZA/hw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950973; c=relaxed/simple;
	bh=LEePhgeA+c4wUWPgrH0V4UdQ6IDyqqR0Km9eK2soupU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=KmXYgRyxUy8RZRhXDEcdJS4dUjuCQgNkSmDpp/bQUdnLqrcCCsmNtTR5N0Q4j4FtMptTz2jiBYuHy5gHUlxWKjfpHk4BLzzhNSLenyAxDJkMM/R7rEFd1lDGabkMtt/CpBluXKqbeYqqvWeCwF3x3TMNT6y7xUE9IiDnrWvtatE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibzg20p9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibzg20p9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768950970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bUD87WoL8alrN45Dp0W0iZwxis7ACA2ngLoImtzCs5I=;
	b=ibzg20p95sLCoE/cWu5CDkplyc85lQXboT3iHl0F17j1bgDVJcCsRkWCVgeM6jwLYXUcsJ
	yzWSnWSPrKzlQhPFv7xQu/TMpHww5Ybizfdnu02ZV60rCbnfBg6gOn6HwLQEJ4uux5Vmoi
	3W0eUKHbU73KwMvKwtrkAe6+Mcpqt+4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-96MHl7qaOGuI3_ImjVdjfg-1; Tue,
 20 Jan 2026 18:16:07 -0500
X-MC-Unique: 96MHl7qaOGuI3_ImjVdjfg-1
X-Mimecast-MFC-AGG-ID: 96MHl7qaOGuI3_ImjVdjfg_1768950964
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E37EF1956095;
	Tue, 20 Jan 2026 23:16:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DDAA91800285;
	Tue, 20 Jan 2026 23:15:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260120224108.GC6191@quark>
References: <20260120224108.GC6191@quark> <20260120145103.1176337-1-dhowells@redhat.com> <20260120145103.1176337-8-dhowells@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, Lukas Wunner <lukas@wunner.de>,
    Ignat Korchagin <ignat@cloudflare.com>,
    Jarkko Sakkinen <jarkko@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Luis Chamberlain <mcgrof@kernel.org>,
    Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
    Sami Tolvanen <samitolvanen@google.com>,
    "Jason A . Donenfeld" <Jason@zx2c4.com>,
    Ard Biesheuvel <ardb@kernel.org>,
    Stephan Mueller <smueller@chronox.de>, linux-crypto@vger.kernel.org,
    keyrings@vger.kernel.org, linux-modules@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Tadeusz Struk <tadeusz.struk@intel.com>,
    "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v13 07/12] crypto: Add RSASSA-PSS support
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1416721.1768950957.1@warthog.procyon.org.uk>
Date: Tue, 20 Jan 2026 23:15:57 +0000
Message-ID: <1416722.1768950957@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Eric Biggers <ebiggers@kernel.org> wrote:

> As I mentioned in another reply, error-prone string parsing isn't a
> great choice.  C has native support for function parameters.

But is constrained that it has to work with KEYCTL_PKEY_VERIFY's info
parameter.

David

