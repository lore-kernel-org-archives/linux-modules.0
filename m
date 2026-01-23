Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B653502B5
	for <linux-modules@vger.kernel.org>; Fri, 23 Jan 2026 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166844; cv=none; b=kC4bAD1GFqjDwDbWKkkPFcMR+BUF9vxKxj7Gx2gnkm7qxXDLQlwxeNHf/ZjPQIqOCcrCLpJ8Mklm2gKpkFij7GM0pb935LaCwWkOdWMyLn3XBguzoqH4SHI3Wb50loassk4CzywJQqK/xPZ5vgfm3dD8qo9B3AJSLePvhXtbDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166844; c=relaxed/simple;
	bh=Uctvhaao4TwZFvZs8nG3yHG4j63vmM1NOm8Qll9foJY=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=g9vmdgA//AIjptqOhQmVgHwQ4WCZfMwuBDLH3HZvGXqOawYrkH1+CAclAgKZQknejtf2+t7nObuZD1Al2b1NktvhoW6OpwQMruio6HoXqaQvj79bB7C4fWHL/EoUFmUa61+XufincHFPNOropWZ6j4sCzirwpeRIMS4dLKrH468=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLoAXgL5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLoAXgL5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769166835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u+zpIB6rSPmIkhyyL0wrbSSRBgkyqQ8ePd4cJB2UVC0=;
	b=RLoAXgL57RCHKcqCtp9gNTFZJl/PcgIeiyAiR/52rlIyCKz27fRiXWHdvvnaKAicqjCaka
	Y6AWKpvdcVyHDhAyTJz+1HzCxuDu63IObgCgm/74ZOB97okvCw2Kgv78tti6hL5jKmTY2z
	In/+UGtvepBwC2MmwrVh+Pl7nMrSPY4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-KvdH0h4hO1uAyeziSG2IdA-1; Fri,
 23 Jan 2026 06:13:50 -0500
X-MC-Unique: KvdH0h4hO1uAyeziSG2IdA-1
X-Mimecast-MFC-AGG-ID: KvdH0h4hO1uAyeziSG2IdA_1769166827
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20DC418002C7;
	Fri, 23 Jan 2026 11:13:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA48830002D1;
	Fri, 23 Jan 2026 11:13:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260121223609.1650735-1-dhowells@redhat.com>
References: <20260121223609.1650735-1-dhowells@redhat.com>
Cc: dhowells@redhat.com, Lukas Wunner <lukas@wunner.de>,
    Ignat Korchagin <ignat@cloudflare.com>,
    Jarkko Sakkinen <jarkko@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Eric Biggers <ebiggers@kernel.org>,
    Luis Chamberlain <mcgrof@kernel.org>,
    Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
    Sami Tolvanen <samitolvanen@google.com>,
    "Jason A . Donenfeld" <Jason@zx2c4.com>,
    Ard Biesheuvel <ardb@kernel.org>,
    Stephan Mueller <smueller@chronox.de>, linux-crypto@vger.kernel.org,
    keyrings@vger.kernel.org, linux-modules@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 0/5] x509, pkcs7, crypto: Add ML-DSA and RSASSA-PSS signing
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1753971.1769166821.1@warthog.procyon.org.uk>
Date: Fri, 23 Jan 2026 11:13:41 +0000
Message-ID: <1753972.1769166821@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

David Howells <dhowells@redhat.com> wrote:

> Subject: [PATCH v14 0/5] x509, pkcs7, crypto: Add ML-DSA and RSASSA-PSS
>  signing

I forgot to edit the cover to reflect I dropped RSASSA-PSS support from the
patchset for now.

David

