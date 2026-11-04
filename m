Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823188;
	b=MsOLl0cmPolDOBjBTOYNLt2qMnesA8ezKewszieOFT1yyc73zi3IOQwH12QG1RD0cNNh
	 NP5vwk7LxCVaOofIaHGqRIqbA8dpg5/4sU1amOWtzufyyRz6E4f0ZBlv3id/5yQwvkbV5
	 4x87xn3ePfOoZWuSwsUfIkK4WsHc50aDbK8up6vVhBXFQxaomehfNuDi56v1xlNO2HEDw
	 kxlcK3hEkMHJfpGsl1IkZQYfmeal19+I9eg0JuMtjasgMwaN81teHYcNU+rnbhVMqB879
	 PgJo5Mpc2S6ikPq2JclBoJxmHvuNaBNZtiAm1ZtCSdXQSVX5OEtOet6TnFE2Q0dwFhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
	b=yrroi5X29mqTH+5lIC2lxCqJ+X2OgwFeqRw1ySn2Gr2bFz9sfb6bKnBz+8cfjhwyZ8p0
	 AqpLhptN0uJSqTcuMb7eKHiSxkyHFfxmvKWu34c9dcBqsH90j37Ow4uhVzjGZOGzTNmGd
	 224S+uNL07gz/Vfd/2KK1MD7Yz1XV9eHSOvwGqd8+o7N0OAvHihZsNEy8dLSAgg5h3l70
	 iHblHZ/bEZHHtZ3BZUy+REm5BWYv3lepZnOjw3yiFRPFqzGlBbeTInv69+SWz81VFRJDu
	 8AXyvsSoD4FEukM2k3JLDGBUSthZIqTATzl4x5otKPhgOq2kMLgi1Ry/uDziecDnKmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Jvf1gScl;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B595160807BF
	for <linux-modules@vger.kernel.org>; Wed,  4 Nov 2026 20:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B595160807BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Jvf1gScl
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c418e215671so167788766b.0
        for <linux-modules@vger.kernel.org>; Wed, 04 Nov 2026 12:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793823186; x=1794427986; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=Jvf1gSclaVzSC4pbdRzHlHjmRMTQLTecIxqc3YBmSb2pj5kRtL0o41kte3ki2jWbOP
         hF3AJbnmDRajhszkXImvHCutImHnY5JK2r41hXHda+709dSqOcK/vpeFsN++8BCYgAUL
         w8Y2O960L2+W1o5OU68U4Qwp5/3D3y9anprTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823186; x=1794427986;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=wW4/4Aoo6RP8QD7Ct/+lReaTcf12Rs6JBtQ54nL0axuRhTLTXzcomLiuKX35s/pKHM
         alepf5U9AK0sQvdSyB1n+OIETJ1TL/a4CKeniv6g3tm/hUfGvg9BGnjMleKrXqXYJU1N
         glsJCAVlanoZx5nTwpnNM56U9FoRCHdFIO2TOUj/7ORy7DkK2R/f3tVqWD+f5bH5il1w
         Tk3FCl3YemTfARCr9Ob5OWdhQ8KV+y34OB44YczG3XaQQHmZMrrNPkqAtRDBCu8sEV87
         /DUs1/chE9yXf622Td7g9lEXnXt+TGDh4wS+Khr5pXjnNX+d/whCEV9xoUwOP2obKAR/
         WVdg==
X-Forwarded-Encrypted: i=1; AKwUvBxG/z1jdY0UKz/LZ8Kta03zO0Uq1soBGHCd0iz+Uqhgd0ydhgiuo0AE+MPpUyXETYMt4ZpfzFp84/QgPNfv@vger.kernel.org
X-Gm-Message-State: APuU4Z98+LWzYXp1SRDwm2b4sBmSeJEoXl1ExKIakti8j+hwquLZK+cp
	khy1Z0cm55T//TmA5CZr8j9VPR574T8YFXJo8uYKRpbY7jF317B71RIDjAUggY6zIvQmbrnkges
	X6NI6F/atJw==
X-Gm-Gg: AYBFou1bXvdnSiA3XXvCbA599UaYe8w8BrS2NTMcAeuOSreI9IHprMEJSqOueL7ssTg
	izMV401bc7nvL+SOANwp1ZT02Zu3Sn6X6oX5TvcZUcFK7iCBXxtoGwkgZCkx58h4G+XWAh8ctah
	KXWzJwOYzg67w37UVl7epeq1mREwsD0djB1I63f/iWRBi/BNsvzHexgTGhmb6oAwyYqUF+N3xG1
	3aRkfH5z2GcUAmG0K13F5Y27wdKCeLbA9rb4y+9/2YEkO2kbwIsXmx6BKdSVl1S09IwDCdU3wAY
	QtS/TNdMjmgxNuL+h91NRxMGSPHozfaLQ7EA/SMlqvs8sEkVhcqHoK6gzMTurxnVYohxbBPL+Kl
	GoFtqBYZSe1Rm4YbP7fLJQwrN253PYuNSdqgDqOMCYyYU1+X9yFJsuVHC2HZ9vWNpchXOEhNzNZ
	SG7Tp/078k4eaeWKJ0He+ckcV05qPkLIgFUCzpJmi/3d1+aVO/2xnD3waeo6yg45pZnaEqiUo7F
	2BRrBUnoPuhmnDutk+YIsSmkejZOHUL0iNi5R2P/r6VgOn6n0Ac7o1ojHWqrkQVZH+0yEVr+g+O
	KqEFsZRNucZCSTp84riFcP4JaNAbvD09o+jdPwOckZJIgIknOMHSeloxnmr6TQRdUyd37iQPRWL
	r0w==
X-Received: by 2002:a17:906:eec8:b0:c2e:317e:d711 with SMTP id a640c23a62f3a-c4ca7aac250mr1583192566b.27.1793823186153;
        Wed, 04 Nov 2026 12:13:06 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac80752sm1068234a12.31.2026.11.04.12.13.06
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:13:06 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so1563719a12.1
        for <linux-modules@vger.kernel.org>; Wed, 04 Nov 2026 12:13:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzdZokbKw2DRy74rrzDQkp3NmdyakBNFs0OowBOLdfoL35dch9pOm80lNAIQb8vb8yxodt0I3MsPVZJ4PF1@vger.kernel.org
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner> <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus
