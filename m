Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A002F0C79
	for <linux-modules@vger.kernel.org>; Mon,  4 May 2026 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927517; cv=none; b=jgQ3TEmtPRYJH0KaJwKoRrw68No5mHCL0qmMbnTOKy9edXwZKJVNp5fIKSipmCS2Ye0Aa0uISCmEc2k+eAm0v74YWPPfTZ79elJBSY0Ykt84hsDW6A84pCjcslz/2lqjFeZRvgDRQqOCU8Wg8S8D2OfNdC5dIRiYyRCpyBuNzBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927517; c=relaxed/simple;
	bh=+X4aKfH5+OVpm3vGZ/VjSa9qS3W+TcB7Ut9UnHyQiXI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VKEzgwYmsKJm1G/88aN/Ng4rS4xHmDtVgC6v0Z4iqVfSjQfvcReQXGcHAPBz1Mh2oI6ekIS1Vjf1qcy4m8YtTZkinOpJDYwjD9+tJcGmp4C8X4N5R6qg2wyjorqqf277X0+vLtSpu+WrkXDM2ARhdMe90qZwAKO/mRB47q05KXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBEl38gE; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBEl38gE"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-685017d0fbcso2462681eaf.3
        for <linux-modules@vger.kernel.org>; Mon, 04 May 2026 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777927515; x=1778532315; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLQGU0LuNlz4Zubv7aCKGYcLOZf8h5smLjJbQESr+Ek=;
        b=QBEl38gEYYi/TJ5wh7MdyE+WrVlKBpxTWUBlNNE4C1mpHw3Jb0IyAvL0+HmSVOpbOw
         jpoZchSmMhUCMbK9HAa4j55eE+DZ+lFDyNpCYZ+Wwv40m/ZNzb6DhVHt1CtIszzlFsi+
         9gBEvkqCvzwKHzU+/XUW6eBKDOwU9ZCc1dhiQEa6eLMHsOCqaR0b8sbfGzR3BIYGnGwR
         Jy9hzyLljOFfLsGI+kWsOZLb5o9QK6pdANLdFGVFdRu9ZeloboPVh59Ob1qy2km+hK+Q
         yGMxPzDkXYwwL/w3mf+tgDPFHdSY14dQxvxu7oxum7xisfa5QQF9jN+6Ah0jrTVa4iji
         pAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927515; x=1778532315;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLQGU0LuNlz4Zubv7aCKGYcLOZf8h5smLjJbQESr+Ek=;
        b=caZA5TZb62IOC2beS0X1ljSfxeGMhi83y6Z/h83urLFmdJwF+430vZfVePtZc3t+cS
         ag9TPt1bPagLK0WhVXWtEfau2Oae03Ty1YkYf6/DiWeBqaxez4q4ZPfB3JiF/WUNpLNd
         0Dnka6cxMcbPGj+g9wKpK00gs0CgAilmHluXUUs7c0mbX14GxwOHWYyt6t+DjWm/c2nZ
         flx/z/x9Gv51mRIMpfSdEXo8G3JMw0/9jpAB1fPe+CFxR/d3eckNWiTA6Nr39mLWPwhe
         jElgcBKCXflAaaEUje46wsakjrdDXwAVF3ejEJvgzyRYCM6L5Xcte885fCzvO/0PeXHj
         MHxA==
X-Forwarded-Encrypted: i=1; AFNElJ/WNngf6UVEIBUHXWPy3MVDG7+gR21bKcIFrPvIGCNciyHM18g5HoTIK/JRY+UCjpLGafmzyk+cg7JvfL1G@vger.kernel.org
X-Gm-Message-State: AOJu0YxiDccje6jqytwJWznqg0IEFU7IORQjL1kXIHdCK/ejDH43fNBO
	MpRkEcWGyuGumL9g3N6byhHS0DjFi6lHAuS2UwRRri18yai2cwuLPoSo
X-Gm-Gg: AeBDies3MDJcXcm+Q+3GXI7uxZN2EvM544s/lONrmZRSjtlrPM5QaiTAoHUnpTPtTqT
	Coy5MTyA9nDFYi4q67LtHgSO/EE/cpZ1vO2YZApOlkYcs3WxYBydNEx+sb2N5v4IPdf1QCrpIqD
	qKr2OEESHK1x6ii1P1+Vyh1Ck/fk+y0UeFZlWwdAvkCT8GpkjscfSZKJKDJl24hwH9srb6iqx4P
	qm/nKh7rYTJEPslHKbMxBkMb6k2q32zvRLu4r8eX9s3B6mABQ0BDQHYDtrGNdmKHEaQASClLEiR
	J5FN/22uKpMKiIxN2fCHNr7X7LkBaWVnxn5wHEGBV+LGE3vK0LD2QDvF6gO/GYsajhjjsx3TWOP
	m9dLsv0qcsPiA9+jIV0HhRJk7zK0UXiNdNUYxgK8C3FTZb7lCtxmRce9Cv3M9EfuM/5Bj2b32hQ
	ooM3s/3NbRT9pYhn3yfI0UyY2xXYgCTCKjiEPwFfvOW7HG1VEF0xJ/RgvPOhO5ExvqZnSLLx88
X-Received: by 2002:a05:6820:298f:b0:696:21ad:a4de with SMTP id 006d021491bc7-69697a04cd2mr6624440eaf.27.1777927515302;
        Mon, 04 May 2026 13:45:15 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69689266bacsm7144713eaf.0.2026.05.04.13.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:45:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 00/17] dynamic-debug cleanups refactors maintenance
Date: Mon, 04 May 2026 14:45:06 -0600
Message-Id: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avIrBswfwq6SrQQnWogTJQiCO+et
 PwW771QKDMVmMQLmW4ufMaGvhPgdxc3Qg7NoKQapJUGQ0B/kItXKqjQej0arYL1UkNrUqaVn/8
 3L7V+rNpKHl8AAAA=
X-Change-ID: 20260504-dd-cleanups-2-5c37432d5c03
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Shuah Khan <shuah@kernel.org>, Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 =?utf-8?q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777927513; l=3110;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=+X4aKfH5+OVpm3vGZ/VjSa9qS3W+TcB7Ut9UnHyQiXI=;
 b=eZeoVa0Qd8Owe9LQlz9xMEU7nrUTBH/VnXjm8h1wxSJPYkJR7ixIh1LlDUTmBujTCpfs4T1Ag
 IVotui/rTJ/BbmYmnmnuk+Zd3Mp3ihDcEoKx1qkZSDaYNfHsJBblkRU
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

This series is nearly all maintenance: it refactors/splits functions,
tightens an internal callchain, drops linked-listing where an
array,length is already available, reduces verbose=3 logging for
usability, and reorganizes several structs for better organization.

Getting these into linux-next for integration testing would clear the
deck for fixing Dynamic-debug classmaps, which is needed to restore
the un-BROKEN status of DRM_USE_DYNAMIC_DEBUG.

Theyre on master at v7.1-rc2

The "modules" intersection is on the re-composing of struct
ddebug_info, which is a member in struct module, and maps a module's
__dyndbg* elf sections.

The user visible change to /proc/dynamic_debug/control is s/class
unknown/class:_UNKNOWN_/, which is a more visible/greppable indication
of incomplete class definitions.

Coder visible change is to drop the enum ddebug_class_map_type's
unused vals - namely: DD_CLASS_TYPE_DISJOINT_NAMES
& DD_CLASS_TYPE_LEVEL_NAMES

These allowed more symbolic named inputs:
  echo +DRM_UT_CORE > /sys/module/drm/parameters/debug

But theyre unused 3 years later, and probably not worth keeping.
With a removal commit in the log, its easy enough to restore them later.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Jim Cromie (17):
      dyndbg: factor ddebug_match_desc out from ddebug_change
      dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
      dyndbg: reword "class unknown," to "class:_UNKNOWN_"
      dyndbg: make ddebug_class_param union members same size
      dyndbg: drop NUM_TYPE_ARRAY
      dyndbg: tweak pr_fmt to avoid expansion conflicts
      dyndbg: reduce verbose/debug clutter
      dyndbg: refactor param_set_dyndbg_classes and below
      dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
      dyndbg: replace classmap list with a vector
      dyndbg: macrofy a 2-index for-loop pattern
      dyndbg,module: make proper substructs in _ddebug_info
      dyndbg: move mod_name down from struct ddebug_table to _ddebug_info
      dyndbg: hoist classmap-filter-by-modname up to ddebug_add_module
      dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
      selftests-dyndbg: add a dynamic_debug run_tests target
      dyndbg: change __dynamic_func_call_cls* macros into expressions

 MAINTAINERS                                        |   1 +
 include/linux/dynamic_debug.h                      | 106 ++---
 kernel/module/main.c                               |  12 +-
 lib/dynamic_debug.c                                | 504 ++++++++++-----------
 lib/test_dynamic_debug.c                           |  28 +-
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/dynamic_debug/Makefile     |   9 +
 tools/testing/selftests/dynamic_debug/config       |   7 +
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 257 +++++++++++
 9 files changed, 582 insertions(+), 343 deletions(-)
---
base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
change-id: 20260504-dd-cleanups-2-5c37432d5c03

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

