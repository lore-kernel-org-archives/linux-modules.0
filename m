Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280139AE3
	for <linux-modules@vger.kernel.org>; Wed, 20 Mar 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946096; cv=none; b=Q9bo5wFtXYBOdsF/4iWKCK0oxE+YrqW6qD/YeY1KDPq+bOntHtTzK8YuvYKN4V0zMtvRIOm6N2Rm5UB1DhHnMLI1vt5FvUlRgqV6SNFRBZUS1SZSBWwEn9y5HJXETJi7zURXiuMbvwd3uwNFZ0luBVMDOWZDwb93f2QI8H8QWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946096; c=relaxed/simple;
	bh=+9cyUYkt7VUWAMMAQHYqZtyRA+UAQRpG0vJPW8R3Eas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvlBBAkin548OeRG2ZLJPZEaIZpULcPDsO1q1BWOZy/gbNmYAoEKYRvPjqgLWhbbRdL5jneNcEJ6quahriBTiiUM7V/qbBF17wxfSJ9r9afo0OQeMF9Eua9CK0No57q7JgwaLRuk0ZjRiVYb+oCYcn6T0RPh6kWrevoWR7eB7WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=btE0dTBv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btE0dTBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710946093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9w9iGoR0dXTgm6d6FXSqzRK2b6woDYzWRhiWjcKM1U=;
	b=btE0dTBvaDpL5rs0J90teBxfsAUfQrIZ3t2gShouPSJtP2BNwO1163U1k9khLIHQZOzVhA
	XymWfFWfPpyfAsSxUZ7yh6mFHPinAu4aT96jWTo8XsZ1rmq7rhdQZsky78sAky2785BgzD
	BdN+vlxohWJTMOW54QzTRp3d7mLkQxU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-TV_fBbegMDCf8ZW5uW4Uww-1; Wed, 20 Mar 2024 10:48:10 -0400
X-MC-Unique: TV_fBbegMDCf8ZW5uW4Uww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86F431013608;
	Wed, 20 Mar 2024 14:48:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.246])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB1A3111DCF5;
	Wed, 20 Mar 2024 14:48:07 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: lucas.demarchi@intel.com
Cc: emil.velikov@collabora.com,
	gustavo.sousa@intel.com,
	jtornosm@redhat.com,
	linux-modules@vger.kernel.org,
	mcgrof@kernel.org,
	md@linux.it
Subject: Re: [PATCH kmod] libkmod: add user soft dependecies
Date: Wed, 20 Mar 2024 15:48:01 +0100
Message-ID: <20240320144802.62801-1-jtornosm@redhat.com>
In-Reply-To: <7vowjj4oo64a2vquvqaszmzcdvbrlkntcze2btnogvkwwtuddv@uz72wpi2t55s>
References: <7vowjj4oo64a2vquvqaszmzcdvbrlkntcze2btnogvkwwtuddv@uz72wpi2t55s>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

> a night of sleep and I had a dream in which libkmod had the concept of
> "weak dependency". Borrowing the concept from weak symbols, I think it
> makes perfect sense... the symbol is there and it may or may not be used
> by the linker at the end, but the symbol needs to be there until the
> linking phase. At least the parallel makes sense in my head :)
Ok, I like your dream :)

> Also, I don't think we should mix them with softdep like is done here
> after a quick scan through the patch.
Ok, understood, and if a new case for softdep is not going to be used,
it is clearer: better not mixing with softdep processing.

> From man page:
>    softdep modulename pre: modules... post: modules...
>           The softdep command allows you to specify soft, or optional,
>           module dependencies.  modulename can be used without these
>           optional modules installed, but usually with some features
>           missing. For example, a driver for a storage HBA might
>           require another module be loaded in order to use management
>           features.
>
>           pre-deps and post-deps modules are lists of names and/or
>           aliases of other modules that modprobe will attempt to
>           install (or remove) in order before and after the main module
>           given in the modulename argument.
>
>           Example: Assume "softdep c pre: a b post: d e" is provided in
>           the configuration. Running "modprobe c" is now equivalent to
>           "modprobe a b c d e" without the softdep. Flags such as
>           --use-blacklist are applied to all the specified modules,
>           while module parameters only apply to module c.
>
>           Note: if there are install or remove commands with the same
>           modulename argument, softdep takes precedence.
>
>        weakdep modulename modules...
>           The weakdep command allows you to specify weak module
>           dependecies. Those are similar to pre softdep, with the
>           difference that userspace doesn't attempt to load that
>           dependency before the specified module. Instead the kernel
>           may request one or multiple of them during module probe,
>           depending on the hardware it's binding to. The purpose of
>           weak module is to allow a driver to specify that a certain
>           dependency may be needed, so it should be present in the
>           filesystem (e.g. in initramfs) when that module is probed.
>
>           Example: Assume "weakdep c a b". A program creating an
>           initramfs knows it should add a, b, and c to the filesystem
>           since a and b may be required/desired at runtime. When c is
>           loaded and is being probed, it may issue calls to
>           request_module() causing a or b to also be loaded.
Ok, thanks for completing this.
I will include this in my kmod patch (if it is ok for you).

> Also instead of delegating this to the distros, it'd be good if we start
> adding those to the ELF section of the modules with
>
>        MODULE_WEAKDEP("...");
>
> ... to be defined in the kernel in a similar way that MODULE_SOFTDEP()
> is.
Agree, better to define in kernel code, that's the reason for the patch.
Ok, I will implement in that way and I will create a kernel patch too for
this.
Indeed (with a different name), it was also in my mind but I didn't dare to
create something "new".

Thanks for you comments and help

Best regards
José Ignacio

