Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E1D275112
	for <linux-modules@vger.kernel.org>; Mon, 17 Nov 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395318; cv=none; b=dUstd5tglv+Af+ON+M93cxSxUnR6CwLLPUHkb87b8QsMvzPMr9vRUtU2L8KouhTXmYuZqevv8AG1GSqQ2c5vI0687Oqe8oITnMLVWOzuNOS19lKmJVuTGLgTPmR/j1G/QodnA/606VR6rPWm2RtkeEEQiOlz7EKbhVPtZ074NxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395318; c=relaxed/simple;
	bh=IvWsMcb+Yh4OQgVKqlQOqb7kOQu14WaUOMto1enyEz4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=PFdgSRsq3xvabeQEifHz7HkAPVkwHe5E0P01iRKC+Db3Pm5F0Igj8UoUHczuIXcIDiE8udfwG9BCKri9HxOK7JPzaCSqRPLtnmW1w8N86I/Ev9UELSVRVyCa2QCvcxiVb0X508Ul0/VeXblmBAbNdSm2VEr1ZuIju5zY4v4XVz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7u0BYHa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7u0BYHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763395315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xN1tMHSK0V4V/Ye9++bgGmJbF6vFPnFJ43P66UO+n5Q=;
	b=O7u0BYHaidkV6CyTED4xy4fODpYOWz3GCoy1rYeobYVDlnX6uiK1ERhh0ee9ji86BaR6rk
	UrXW3UqO7tY6osrB8/bFtblaiP096R+c2Jc4WkNy3f7FgOaCJAfbnzI6lc8ACkBEnCPcmE
	cA3BfkroMkVubSz6q74LbWe+Jq6u+o4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-BuuLYLfTOkKQ9jkBXfwKiw-1; Mon,
 17 Nov 2025 11:01:51 -0500
X-MC-Unique: BuuLYLfTOkKQ9jkBXfwKiw-1
X-Mimecast-MFC-AGG-ID: BuuLYLfTOkKQ9jkBXfwKiw_1763395305
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6C1A1802AAD;
	Mon, 17 Nov 2025 16:01:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 785E33003778;
	Mon, 17 Nov 2025 16:01:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20251117145606.2155773-1-dhowells@redhat.com>
References: <20251117145606.2155773-1-dhowells@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>,
    Luis Chamberlain <mcgrof@kernel.org>,
    Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
    Sami Tolvanen <samitolvanen@google.com>,
    "Jason A . Donenfeld" <Jason@zx2c4.com>,
    Ard Biesheuvel <ardb@kernel.org>,
    Stephan Mueller <smueller@chronox.de>,
    Lukas Wunner <lukas@wunner.de>,
    Ignat Korchagin <ignat@cloudflare.com>, linux-crypto@vger.kernel.org,
    keyrings@vger.kernel.org, linux-modules@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Where to add FIPS tests
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2158595.1763395299.1@warthog.procyon.org.uk>
Date: Mon, 17 Nov 2025 16:01:39 +0000
Message-ID: <2158596.1763395299@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Herbert,

I'm wondering from where I should invoke the FIPS tests for ML-DSA.

Currently, the asymmetric key type has some FIPS selftests for RSA and ECDSA
built into it, but I wonder if that's the best way.  The problem is that it
does the selftest during module init - but that can only test whatever
algorithms are built into the base kernel image and initialised at the time
late_initcall() happens.

It might be better to put the tests into the algorithm modules themselves -
but that then has a potential circular dependency issue.  However, that might
not matter as the asymmetric key type won't be built as a module and will be
built into the kernel (though some of the components such as X.509 and PKCS#7
can be built as modules).

If I don't involve X.509/PKCS#7 in the selftest, then doing it from the ML-DSA
modules during module init would be fine.

Do you (or anyone else) have any thoughts?

David

