Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CDA35A3A7
	for <linux-modules@vger.kernel.org>; Wed, 11 Mar 2026 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238307; cv=none; b=qlb0nMsGnVciodlj7DQetVGpW28+CrRWAP/2gYsQfyDQQBiKIhtN4TdRKQHZBsasMWpfNcqkVRHjh3gT18Bcj7yg0lUNDyB/17l+T9oKuEQHw8SxeZAhC1GPWv9dNZRSfgYg6zSKNGvFDShg+9HNwpvlI6doSS0DIhJSU8q3Guw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238307; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaC1LJNumj/Yy9iqbWCmqhTKsmHVS2YNpkNSCvWWk3fIP1nrXgFqzyBhEIjSO4HbakMd2dOE8Y8N+r+K7R4ROee4HGLfz1zQAQLnNhFuAZQjpkdSG/juB+rrAByiYLwMwq4qNCOjdoNthQ6ZfxmDC+HoiG9rbaVHpesHiGNBw7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-660be63279bso1541535a12.1
        for <linux-modules@vger.kernel.org>; Wed, 11 Mar 2026 07:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238304; x=1773843104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=nY/dQlk5aRG74vwHve+cGgHsYEah2c4lEFMxspNQX+tlHW6ADicmxIKvjPWjwJ2vrO
         Uc9p5D2wbJZ3QRXWwDhOP/Y4XY4pV6ZmB5+0vfqvUlkrtY2bWK81z3oyhLMA4az1dE3L
         OTpy0sKP9hCP7V4ugcKFtqPsQhd74MdpbYT+wX/gz5NcR+di3nTj5qs9J6kWPonKk5oK
         vyVcWsLDFkz1ctyUnVZUvNTkFPzY40vKQbSAtnTW8wkbf/0uh7nWlNipnP+1j5pv7Y1m
         g9Kmr0nQsS48C0D4LtnQjHI/hFxwG+g6LNpB/DLIlclcmyle+ApEqH1yd4xqt7v/B8OL
         O/Kg==
X-Forwarded-Encrypted: i=1; AJvYcCW9gw1TkWtM6hR+R/UZRGYmMbuZ1TWQhRor51bEuLHBu8DJUfBp9PWViQipyXk5u6zAsE7BLwP9egAl2gkm@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+Wg9S7l8FBeqy7gjRq+eZ2v16Ri6OY4KZzVrAd7l1zm7MSfI
	Y6FnGC6naobLYA5cJz85CPU1KVfEj+hIgKAuP8hIcq1hhSTd47cYz0EBI6H7Krk1y+oYRA==
X-Gm-Gg: ATEYQzxOOnbbhbN8hxVe90V58DhtR9oQEVL5SjvqSfYKfKkuumaf8sGxUckD5pKxNmd
	pEqjFAlXKroh4srhDjf3Ta+VvPF7hd44OmEoiHTNu69aRNmCrZA0UTOn/n6wo+pKqNXw1SIRzUt
	Sl3naCXdhjwbqxaP1s2aY1RK9WO0oM8tUXOvOT5gF8rtzkAHiQ7Axl5kuVKW5ElLoEachOzBZ6F
	t2B/8kpXzg+5o3KuerVF2YCIQi1kQ9LCEDHnFOAe1fByeU0D+ZmJ4LX0ZM8E1a1Dt17FTLG2Bu+
	y6PRMmU7tOt4wc8KHNBX9rc0oUCX7pG/ajpmoafJRRULaOXZCv+sVV8AyozgdIq/JI7NBHy/NqX
	jB8AK+f9MB8NXuN9GDC2j8TYad0RGJ5F3Mmblnf9ZLZBLb6a4Jthe+xbAvOG9pqwe2utMA+DxlD
	zk/3AzJkrLYPsdHhO9pIzpHVOE6kK/2u1vZbf4L1VxMRQ9+VH39Vz1BP1yRdQD
X-Received: by 2002:a17:907:9611:b0:b97:5dc:3bd9 with SMTP id a640c23a62f3a-b972d524650mr176857966b.8.1773238304072;
        Wed, 11 Mar 2026 07:11:44 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972e14a2c6sm57445766b.42.2026.03.11.07.11.43
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:11:43 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9423d62cbbso151059866b.1
        for <linux-modules@vger.kernel.org>; Wed, 11 Mar 2026 07:11:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXO6G9nK32gDpWnZG/HaUQLeHevo0g0ktw2vbv02yIos6MW83NSSZc786s3+bENgmYvApXTSyaAXN79B7U7@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
