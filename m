Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DFD1EF94F
	for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717709; cv=none; b=m2+qGPkZlRXvvwUuGhHfMEF3MNnUHSLrxjOKuxpQIfKpLVq4uF6ZNAsCWXraX5xIQCh7K1SOvzSnlus0rD2Rw/5waAGSX3QvzNTC7HvF6VaoH4t4Fo1XizSMYPKu7+zW3OUeG56FiYO2cUYWr8P5KstKvtb0v1cFMk4n3OFT/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717709; c=relaxed/simple;
	bh=l6GhtOLjTV4WPuga7aMEtfVG7+2QgeqWsQOgmFoTN34=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NmPKFgNtoAZNC7bfEKJ0G3VMYu5k1bgc4fG2LZSHhrcpI1VlTLKSYRJYV1lg8Jess61nNaBd5UlyWjxyTD+QGl2A1xrd4yrhVPbfT47yMF/SnGoNxK9S4cgBj6N1DY6iQVyeggoW0jX3D7ruyvBylXj3c5sWpTwRrrTLR7KVCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3CCkdcl; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3CCkdcl"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f72c913aso300366e87.1
        for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 14:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729717706; x=1730322506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wC5CorFNxet/K6XJjDD+4xYSSsvi0kb6UDd17WYIu7Y=;
        b=b3CCkdclYHtibVmM/odBdUsQr45+1PQf0/6xC3pbanZflLQYfeE4q28o6aV/c5vB7o
         QFe6dHP5jyGCJ3INxuPIAZfKOGQ35Q94CSrfmqfMX/nwqzcBij+B3Tc9gk6s/EOKKnCH
         MvGFjVbruonL+WRakqzXeRHQos6W486OoJNobmNa06ph2bKFf1NppsDFocvWH//9Tzdd
         coJQkXfeOwmlxs+cXVEkz0Uiaj7wNrVWCYQyid9VF4kC4JtjGYwKAWwqIIMptBHIJVZf
         oGrp8J+BiNp8UHJ7agSnV7wdRsmK+2Uxx5xjvO96DSNqvgOnMtXC/ODbcuSKGlP8HrMp
         zPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717706; x=1730322506;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wC5CorFNxet/K6XJjDD+4xYSSsvi0kb6UDd17WYIu7Y=;
        b=RBajXCog5Dc2lyyYLdZfzGLjW/824LDW+DDjURJqKQLQu9u32Yh7hsaaYg3w2f/jXe
         xhbqoAcEgu4ioYD2e8WRW22W1QeQlA9Ttsajx9EqtmBQb2WOogOvviiMVEk2MOCfDVkp
         twT7tV1fKnSWxOd5ArCjIkZQAslIdObieGFjESg4PJjNzxRLR1OPHgRXQXW8hOK/ij5X
         aYnHCrGSyo/K7Xp/BxOYKdHB4VW5+5TBO4Lu9U5O4Jm5dD6lkvHrrsCIOEMrpgaRPnnD
         9tWTMrBkaKo8BPGtPIokGz8yfJX98ReQoS2a1dmXB9ejaclqTRg6VkADsL9WV7sU90cW
         ZYIA==
X-Gm-Message-State: AOJu0Ywnu2EpmlmBYhvVJugGN2G55SP/gQwdCZhEcY+Ypntdyme2FDUN
	bfBVxOJMK8qkpTiTIQpXFhCRxM+LAiSaCieJtWhU/2GYZ5GmOzITqyZgicXgf6vJqiUeC7YqU2n
	XmGo5oQeEef0rlS9+NRC7N53g5Mfv4lpNI8o=
X-Google-Smtp-Source: AGHT+IEX0W1DzvvhrCAt5G8uUzT/vu0TGof4KLbTrUTBqI3oS54SHGyC5IgFvnLjzciQIIdYv4GcQB1SolR0XsYF7I8=
X-Received: by 2002:a05:6512:1189:b0:533:3fc8:43ee with SMTP id
 2adb3069b0e04-53b1a3030f0mr2450098e87.13.1729717705869; Wed, 23 Oct 2024
 14:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 23 Oct 2024 23:07:49 +0200
Message-ID: <CA+icZUVTpf+XjDp=Mh0ghuk2tQwkgGd0OMUzK++RBSfhBk4+aQ@mail.gmail.com>
Subject: meson: always pass complete path to kmod-symlink.sh
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-modules@vger.kernel.org, lucas.de.marchi@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Emil,

commit 844835cd9a4e5f08e1a3eefb4928c5d769264894 breaks when NO DESTDIR is set:

meson compile -C ../build

meson setup --native-file build-dileks.ini ../build

[ build-dileks.ini ]
; SPDX-FileCopyrightText: 2024 Emil Velikov <emil.l.velikov@gmail.com>
; SPDX-FileCopyrightText: 2024 Lucas De Marchi <lucas.de.marchi@gmail.com>
;
; SPDX-License-Identifier: LGPL-2.1-or-later

[project options]
build-tests = false
debug-messages = false
docs = false
zstd = 'enabled'
xz = 'enabled'
zlib = 'enabled'
openssl = 'enabled'
werror = true
strip = true

[built-in options]
buildtype = 'release'
-EOF-

sudo LC_ALL=C meson install -C ../build
...
Running custom install script
'/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/depmod'
/home/dileks/src/kmod/git/scripts/kmod-symlink.sh: line 10: DESTDIR:
unbound variable
FAILED: install script
'/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/depmod'
failed with exit code 1.

Works:

sudo DESTDIR=/bin meson install -C ../build
...
Running custom install script
'/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/depmod'
Running custom install script
'/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/insmod'
Running custom install script
'/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/lsmod'
Running custom install script
'/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/modinfo'
Running custom install script
'/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/modprobe'
Running custom install script
'/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/rmmod'

$ ll /bin/*mod
-rwxr-xr-x 1 root root  67K 23. Okt 17:36 /bin/chmod
lrwxrwxrwx 1 root root    4 20. Okt 00:19 /bin/depmod -> kmod
lrwxrwxrwx 1 root root    4 20. Okt 00:19 /bin/insmod -> kmod
-rwxr-xr-x 1 root root 172K 23. Okt 23:02 /bin/kmod
lrwxrwxrwx 1 root root    4 20. Okt 00:19 /bin/lsmod -> kmod
lrwxrwxrwx 1 root root    4 20. Okt 00:19 /bin/rmmod -> kmod

Set a default for DESTDIR (destdir)?

Best regards,
-Sedat-
