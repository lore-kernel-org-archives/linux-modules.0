Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E0715383E
	for <linux-modules@vger.kernel.org>; Tue, 14 Jan 2025 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878065; cv=none; b=ARDlNoKuXM9Ucb7oQzjThwlkDNmEmYrtgthyu6a6U5EAgM22sRVECLSXCFqD1KPiWzmp4OTcSj5RfC45nFR6OZDsUXgRYyaC3VXMfld7i2Gb1mvk+qsMNWGOE6oZ4EoEGeR2Q6XjTaQ2XTMHKP2k+X8WLzpMlXM/AMNoPH7Nano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878065; c=relaxed/simple;
	bh=OeJp5LYk/nKjtL8S3iJvmhpCxQW0wW3ln/Cx8rgKLWE=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=noyl5eAyUpsjRLJkQDp+Sbe+fCun2kio10qdml7pN4R81umjp9PpPwFae82l24IoRUT5iSZzAfLPh2NsD81KedGZB2tn0yeJhp7RHLr90vLBgjhUYH8EplKQf737TOApa0styTgDToDOuoJbOJihM0jDl9FzpqcQTrgtVs7Eu8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5jQRptb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5jQRptb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736878062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=PXEJPnam5sKLBm4gC/JbVd11Ubf3i60g5D7nHHLsTbc=;
	b=A5jQRptbeOkoQlFa71i0CPvfimo+8ZhxD1BV5Zf1eySif+sjPPxQyGKlUO+EsGVNQDp6za
	hFdp6vmCiN17XV7thBgI/AILJxMhjsiGk8LS7vi9k+QyvmiIwy6KqYR7QM6Itx+eHKkT2g
	S4eSsnUmqS0WW72KI2csk4uBhBf6KhQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-1CfPXEUqNZGUSs9jbafS3g-1; Tue,
 14 Jan 2025 13:07:39 -0500
X-MC-Unique: 1CfPXEUqNZGUSs9jbafS3g-1
X-Mimecast-MFC-AGG-ID: 1CfPXEUqNZGUSs9jbafS3g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ED3C1955DC9;
	Tue, 14 Jan 2025 18:07:37 +0000 (UTC)
Received: from [10.45.224.117] (unknown [10.45.224.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B65B19560A3;
	Tue, 14 Jan 2025 18:07:34 +0000 (UTC)
Date: Tue, 14 Jan 2025 19:07:30 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
    Sami Tolvanen <samitolvanen@google.com>, 
    Daniel Gomez <da.gomez@samsung.com>
cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    Helge Deller <deller@gmx.de>, linux-modules@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Unaligned accesses when loading modules
Message-ID: <1665d54c-178f-ff72-e627-776e7c76798b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi

On PA-RISC, with the kernel 6.12.9, I get unaligned pointer warnings when 
a module is loaded. The warnings are caused by the fact that the 
.gnu.linkonce.this_module section is not aligned to the appropriate 
boundary. If I dump the module content with "objdump -h configs.ko", I get 
this. Note that the .gnu.linkonce.this_module has "File off 000042d2" and 
"Algn 2**4".

On x86-64, the same misalignment can be seen, but it doesn't cause 
warnings because unaligned pointers are handled in hardware.

This seems to be a bug in the linker, because when I compile an old kernel 
with a new linker, I also get the misalignment. Do you have an idea how to 
work around this bug?

Mikulas


kernel-6.12.9, binutils from Debian ports:

configs.ko:     file format elf64-hppa-linux

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .text         00000040  0000000000000000  0000000000000000  00000040  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .init.text    00000070  0000000000000000  0000000000000000  00000080  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  2 .exit.text    00000028  0000000000000000  0000000000000000  000000f0  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  3 .rodata       00004015  0000000000000000  0000000000000000  00000118  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 .rodata.str1.8 00000010  0000000000000000  0000000000000000  0000412d  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 .PARISC.unwind 00000030  0000000000000000  0000000000000000  0000413d  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  6 .modinfo      000000a1  0000000000000000  0000000000000000  0000416d  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  7 .note.gnu.build-id 00000024  0000000000000000  0000000000000000  0000420e  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  8 .note.Linux   00000030  0000000000000000  0000000000000000  00004232  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  9 .data         00000000  0000000000000030  0000000000000030  00004262  2**0
                  CONTENTS, ALLOC, LOAD, DATA
 10 .exit.data    00000008  0000000000000000  0000000000000000  00004262  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
 11 .init.data    00000008  0000000000000000  0000000000000000  0000426a  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
 12 .data.rel.ro  00000060  0000000000000000  0000000000000000  00004272  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
 13 .gnu.linkonce.this_module 000002d0  0000000000000000  0000000000000000  000042d2  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, DATA, LINK_ONCE_DISCARD
 14 .bss          00000000  0000000000000000  0000000000000000  000045a2  2**0
                  ALLOC
 15 .comment      00000039  0000000000000000  0000000000000000  000045a2  2**0
                  CONTENTS, READONLY
 16 .note.GNU-stack 00000000  0000000000000000  0000000000000000  000045db  2**0
                  CONTENTS, READONLY

With the kernel 6.10, I get this - the ".gnu.linkonce.this_module" 
sections has "File off 00004210" and "Algn 2**4" - so, it is properly 
aligned.

kernel 6.10, older binutils:

configs.ko:     file format elf64-hppa-linux

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .note.gnu.build-id 00000024  0000000000000000  0000000000000000  00000040  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  1 .note.Linux   00000030  0000000000000000  0000000000000000  00000064  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .text         00000040  0000000000000000  0000000000000000  00000098  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  3 .init.text    00000070  0000000000000000  0000000000000000  000000d8  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  4 .exit.text    00000028  0000000000000000  0000000000000000  00000148  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  5 .rodata       00003f45  0000000000000000  0000000000000000  00000170  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 .rodata.str1.8 00000010  0000000000000000  0000000000000000  000040b8  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  7 .PARISC.unwind 00000030  0000000000000000  0000000000000000  000040c8  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  8 .modinfo      000000a1  0000000000000000  0000000000000000  000040f8  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  9 .data         00000007  00000000000000a1  00000000000000a1  00004199  2**0
                  CONTENTS, ALLOC, LOAD, DATA
 10 .exit.data    00000008  0000000000000000  0000000000000000  000041a0  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
 11 .init.data    00000008  0000000000000000  0000000000000000  000041a8  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
 12 .data.rel.ro  00000060  0000000000000000  0000000000000000  000041b0  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
 13 .gnu.linkonce.this_module 000002d0  0000000000000000  0000000000000000  00004210  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, DATA, LINK_ONCE_DISCARD
 14 .bss          00000000  0000000000000000  0000000000000000  000044e0  2**0
                  ALLOC
 15 .comment      00000026  0000000000000000  0000000000000000  000044e0  2**0
                  CONTENTS, READONLY
 16 .note.GNU-stack 00000000  0000000000000000  0000000000000000  00004506  2**0
                  CONTENTS, READONLY

