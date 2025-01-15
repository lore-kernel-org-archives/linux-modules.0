Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00E199244
	for <linux-modules@vger.kernel.org>; Wed, 15 Jan 2025 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736964141; cv=none; b=W1JHIbpzrWlEMDF2ArV6//DiyIZ5K1A+nxUw80XDDpVr1cP0JFKHWSER5LmtuB2PLudjMBtZQyMVAq1I3mxcQ9F2cmtLycgXrM3XkbX4QfNsHhfJVpbPinNC/xmlpqcOCDXEfHkjnTiHThrRX6/0jTwLW4ImMkCh6TwU7BMonVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736964141; c=relaxed/simple;
	bh=L8iQE9znvPYl9DK+Utmba7vgizZ6KeTfnPRxqMFHCbo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZWUkT/llhp/3KXxJxb+IGLncEsdwnF6Lt9BN1kxjW+DLqy99RBjUjj1xXwnfJqGuUQQxxZdNTxG7KYHLqSo/MJLoLCxUUcQQR8KoBqT9QFMK+AAbTgZg0mS+SktKofF0cATUFOGX5AfBc5+QweXx3w5Mn+Vob9K3Bjl9NfpWbPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAi4LQSb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAi4LQSb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736964138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=amZzykVUdaXkmmVTMsZzyU+hoxh5TAQCfouleZRcoe4=;
	b=NAi4LQSbMm1lGxe34ocXL775uVZ5wnYO3nzIyAQUA1Td528nUdMy+A1iasEBKaEBSC6pkr
	yViARQdbzhmtT+W84DRoDiPBUoHT15oqoyJlOpqCwWezlzuBxnJBPgJjJArCHDCLjfVmOL
	u+1A8D6+l+FtNm7CIE5guqZBtRDOPXE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-v7NGs5lNOqqt6P7UQvGW8Q-1; Wed,
 15 Jan 2025 13:02:12 -0500
X-MC-Unique: v7NGs5lNOqqt6P7UQvGW8Q-1
X-Mimecast-MFC-AGG-ID: v7NGs5lNOqqt6P7UQvGW8Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F8DE1956048;
	Wed, 15 Jan 2025 18:02:09 +0000 (UTC)
Received: from [10.45.224.117] (unknown [10.45.224.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B19DC19560A3;
	Wed, 15 Jan 2025 18:02:05 +0000 (UTC)
Date: Wed, 15 Jan 2025 19:02:01 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Sami Tolvanen <samitolvanen@google.com>
cc: Luis Chamberlain <mcgrof@kernel.org>, Jan Beulich <jbeulich@suse.com>, 
    Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, 
    "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
    Helge Deller <deller@gmx.de>, linux-modules@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: Unaligned accesses when loading modules
In-Reply-To: <CABCJKud9RCJzVZ2VuTRoaBavOC9bnyTv_W_-AC3mGOy9AY7dWA@mail.gmail.com>
Message-ID: <aedcb0fd-040b-0dcc-8c28-34a0b07d5a7e@redhat.com>
References: <1665d54c-178f-ff72-e627-776e7c76798b@redhat.com> <CABCJKud9RCJzVZ2VuTRoaBavOC9bnyTv_W_-AC3mGOy9AY7dWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811712-2009256048-1736961017=:102379"
Content-ID: <e419cb5a-1942-28e7-2f82-eb15d63c24c6@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811712-2009256048-1736961017=:102379
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <609e0e9e-78c0-43c5-c3b6-4b16de125ac2@redhat.com>



On Tue, 14 Jan 2025, Sami Tolvanen wrote:

> Hi Mikulas,
> 
> On Tue, Jan 14, 2025 at 6:07 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > Hi
> >
> > On PA-RISC, with the kernel 6.12.9, I get unaligned pointer warnings when
> > a module is loaded. The warnings are caused by the fact that the
> > .gnu.linkonce.this_module section is not aligned to the appropriate
> > boundary. If I dump the module content with "objdump -h configs.ko", I get
> > this. Note that the .gnu.linkonce.this_module has "File off 000042d2" and
> > "Algn 2**4".
> >
> > On x86-64, the same misalignment can be seen, but it doesn't cause
> > warnings because unaligned pointers are handled in hardware.
> >
> > This seems to be a bug in the linker, because when I compile an old kernel
> > with a new linker, I also get the misalignment. Do you have an idea how to
> > work around this bug?
> 
> Does explicitly specifying section alignment in the module linker
> script fix this by any chance?
> 
> > kernel-6.12.9, binutils from Debian ports:
> > [...]
> > kernel 6.10, older binutils:
> 
> Which exact versions of binutils were used here? I don't see the
> alignment issue with binutils 2.42 on either x86_64 or parisc64, so I
> assume you're testing with something newer?
> 
> $ hppa64-linux-gnu-ld.bfd --version
> GNU ld (GNU Binutils for Debian) 2.42.50.20240625
> 
> $ hppa64-linux-gnu-objdump -h configs.ko | grep -E '(format|this_module)'
> configs.ko:     file format elf64-hppa-linux
>  17 .gnu.linkonce.this_module 00000300  0000000000000000
> 0000000000000000  00005c50  2**4
> 
> Sami

Hi

I use version "GNU ld (GNU Binutils for Debian) 2.43.50.20250108".

It was broken in the commit 1f1b5e506bf0d9bffef8525eb9bee19646713eb6 in 
the binutils-gdb git and partially fixed in the commit 
d41df13ab36b224a622c0bdf28a96a0dee79db77 - the section is still not 
aligned at their specified boundary (16), but at least it is aligned on 8 
bytes, which avoids the warnings.

With binutils from git, I no longer see warnings when loading modules, but 
there are warnings in modpost when compiling the kernel:

2025-01-15T17:09:29.408347+01:00 phoebe kernel: handle_unaligned: 2165 callbacks suppressed
2025-01-15T17:09:29.408433+01:00 phoebe kernel: modpost(9283): unaligned access to 0xf9096bd5 at ip 0x015d03 (iir 0xf381086)
2025-01-15T17:09:29.602490+01:00 phoebe kernel: modpost(9283): unaligned access to 0xf9096bd1 at ip 0x015d07 (iir 0xf301088)
2025-01-15T17:09:29.700610+01:00 phoebe kernel: modpost(9283): unaligned access to 0xf9096be9 at ip 0x015d0b (iir 0x4b3c0040)
2025-01-15T17:09:29.700653+01:00 phoebe kernel: modpost(9283): unaligned access to 0xf9096bdd at ip 0x015d0f (iir 0x4b240028)
2025-01-15T17:09:29.897081+01:00 phoebe kernel: modpost(9283): unaligned access to 0xf9096bd9 at ip 0x015d13 (iir 0x4b270020)

The affected instructions are in the function do_pci_entry:
   15d00:       0f 38 10 86     ldw c(r25),r6
   15d04:       0f 30 10 88     ldw 8(r25),r8
   15d08:       4b 3c 00 40     ldw 20(r25),ret0
   15d0c:       4b 24 00 28     ldw 14(r25),r4
   15d10:       4b 27 00 20     ldw 10(r25),r7
   15d14:       0f 28 10 89     ldw 4(r25),r9
   15d18:       82 93 20 e0     cmpb,= r19,r20,15d90 <do_pci_entry+0xcc>
   15d1c:       0f 20 10 8a     ldw 0(r25),r10
they happen in the expansion of the macro DEF_FIELD.

Mikulas
---1463811712-2009256048-1736961017=:102379--

