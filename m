Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2413212D
	for <linux-modules@vger.kernel.org>; Tue,  9 Jul 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511172; cv=none; b=YY/Sj+xTPb4+EbjIVC3JHDnqQMDXnukNCgoCQ1jI21jvpAZxJcPNwGMWjWVSkFNIrN86vuvByWOnxZNlwRHfw0Go50oJCrxnRv4M+Ctuk55rkTPmps9WHyV2XM5O/1zJfAtFMMwi0nN9J3W9k9GigZzk1hrMAZs22MCddnn+0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511172; c=relaxed/simple;
	bh=Odg3B155mdaYV/grBfTxKLgNybZCFxJqj7KupC/8HVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=impBEjrRIQxg4Dwz8HOURDI7phBlEWe5BcnLjsKc6dzD3zNiMy7urv84BdaJ3YSvzQLatzWSWWMewroCjJpgzaN4cp8m6SlSEAictJbTtFGJf0gtVZcxNE/qZfYzOnvg9Qtgb2qZon19WBVXbJh453X5pBV5bmPBLzUNYUsYkXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=heG6TIvv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heG6TIvv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720511169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mACayD5AYHS+xw2+EP+bDeIlyuLbxCuR4Y/5wRgyA3k=;
	b=heG6TIvvg0uWeZfRBNpRsCr9by8pUT89G4TJ1TasnMoagx1c2gSaRnhQQVBM/UqT5NWWYt
	FaqrMn1tLIXFvLTECexJBBvCP8J9fDEpCdWTW2E3hJYkulLPGTDzZRS+CRQnEkri9hmCLO
	oYemtuURe9KoS7hDHffM4TCQcmWVExI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-YKyo1cP0OXCt8Z5Wd0zMmw-1; Tue,
 09 Jul 2024 03:45:59 -0400
X-MC-Unique: YKyo1cP0OXCt8Z5Wd0zMmw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D36181935DE5;
	Tue,  9 Jul 2024 07:45:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.37])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 841E41955E83;
	Tue,  9 Jul 2024 07:45:56 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: lucas.demarchi@intel.com
Cc: emil.l.velikov@gmail.com,
	jtornosm@redhat.com,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH kmod] testsuite: add tests for weak dependencies
Date: Tue,  9 Jul 2024 09:45:49 +0200
Message-ID: <20240709074554.20855-1-jtornosm@redhat.com>
In-Reply-To: <lozgnoo3vnuzuezii2pdhxzoy5efmxtlwivugoze4hxr2bechc@mr6kegfejniw>
References: <lozgnoo3vnuzuezii2pdhxzoy5efmxtlwivugoze4hxr2bechc@mr6kegfejniw>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hello,

>>Seems like this commit has regressed make distcheck on my end. Namely
>>I'm running the following commands:
>>
>>git clone ...
>>cd kmod
>>git clean -fxd
>>./autogen.sh c
>>make distcheck
>>
>>Result in:
>>
>>...
>>make[5]: *** No rule to make target '.../kmod-32/_build/sub/testsuite/module-playground/mod-weakdep.o', needed by '.../kmod-32/_build/sub/testsuite/module-playground/mod-weakdep.mod'.  Stop.
>>make[4]: *** [Makefile:1903: .../kmod-32/_build/sub/testsuite/module-playground] Error 2
>
>I added a fix in
>https://lore.kernel.org/linux-modules/20240709044758.67725-1-lucas.de.marchi@gmail.com/T/#t
>
>and also sketched the new CI hooks using github.
>
>>Can you reproduce it on your end?

Sorry Emil, I only tested with 'make check' and I didn't try 'make distcheck'
(really I didn't know it).
Yes, it was failing for me too, and I have verified that with the solution
from Lucas ([PATCH 2/3] build: Add mod-weakdep.c to EXTRA_DIST) is working.
Thanks Lucas for fixing it.

>>
>>
>>- Is this work related to the weak-modules used in RHEL/Fedora [1]?
>>  Alternatively, would the RedHat team consider having the weak-modules
>>  solution in upstream kmod?
>>
>>... assuming Lucas is OK with the idea. I'm approaching with with my
>>dkms co-maintainer hat on, where the fewer "if distro == X" logic we
>>have the better.
>
>I was not familiar with that weak-modules and will wait for Jose to
>clarify.

weak modules concept is very different from weak dependencies and not
related. Let me try to explain:

weak modules is about keeping KABI compatibility between kernels with
the same version, in order to reuse modules (internal or external ones),
so it is mainly for RHEL and the update process.
For Fedora, that is the upstream distro, and with no guarantee for KABI,
is not necessary. 

weak dependencies is to be used by upstream (and everywhere) to allow user
applications to be aware of internal dependencies that are not declared as
softdep because they are dynamically loaded.
dracut has approved this feature from yesterday and I am waiting to have
the kernel declaration in linux master branch to apply some weak dependencies
(i.e. lan78xx).

Best regards
José Ignacio

