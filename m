Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287E459AE9
	for <linux-modules@vger.kernel.org>; Fri,  2 Oct 2026 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929947; cv=none; b=H0w8f5CFK3AcV8CQiU0STDhMXn5QQw6ozGY0G/KXL/C4RiQpQyopdAXo4qjQbE3wNWyKWh4m+25DkgZ4zJi+OY+xogjVt5GAf6879OMizVSYjwjsQ/pj0x+MMI7aFNkWd2ZIefvp0aNtmKIYcsw9m7GebuIl0oIajYHv1ivens0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929947; c=relaxed/simple;
	bh=EgqUB+DoKqq6OdA2iGZBD4HDoUMih1j7Hjl6LdTfq+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDe+H0frx/Mg7oxqiHmrLiypK/GPUKlbMgQ+mauLt5r/jWZj+Ga6Fl03eFGeO/WjzhBaq16ZXvualeHQtBpII+UVgn/zJO8P/1qzHkkAjVYvKFExOz2O35CYlocBDa/IqGJJc2FlOzJGMeBUnAqWWUmhaonzUfYkdbh7/IOm4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nyn3a88T; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nyn3a88T"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af9f88c95so1174251f8f.0
        for <linux-modules@vger.kernel.org>; Fri, 02 Oct 2026 01:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790929942; x=1791534742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5JuY5wMUTyN0P+KeYJB0ZAeckebQaYADB7Uozry53MU=;
        b=Nyn3a88TOZtlgUwXBQxc99DKzD5cFPgYsqvYvDeQwuAmd8ZmJn0iuNV/Q+c1/wucVB
         zzUsZx4MycUbiDevM2/3mVWsrsq83OvHZitjpilMq50kbLXwEAuL/gkDz8kmL2rID9TN
         9C9duiA8OpJDOe81uhktZU2HpmpC2ZJKWCJDRaojX5FQpEm2OJv7z5TcKeCwwh/20hRp
         qwchnpBQY39cOcpQkuR4dYP7JgRuh+jDGQpoxkCcpKst2Gwm6+fbG1WmEd/Bl1nUIwTO
         QlzwsvcYDuZoIhYKWAvxKLTusMQYC1w3u9iaDJE3GRLFswFPJIiFSo2GHrKbY8tu2GsM
         yhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790929942; x=1791534742;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5JuY5wMUTyN0P+KeYJB0ZAeckebQaYADB7Uozry53MU=;
        b=asPaFwMxAwA7bgxXwXleJ6mygBgIYU/Ku+hRaDiWdG6phMsW7VQfyYTNcW5f1TXcCE
         JM7Rf1YtsFMPq70882NVlDSvm7Tx2UsZNDNH+KVyJ60gELO/TDCroa/2wz3Rj/G7TV1b
         cLBGauEfsrZn27eb9xoMwELjfXdHjMLVuDlrqxkum6W7k5uZ+wsEIL1VI++6T/rc+gke
         YUVozXVfwjvryLCIucgVpk8596UX9oG/L8mabVMPQyyg+XkOC/adds4mSUok6uzY4Du+
         5GQtRrAikTn80in/rCgObMi5WK8DMOg3gj3xwWQhj4aFzinSmXah4L0feq30bByPXSlA
         yaxw==
X-Forwarded-Encrypted: i=1; AKwUvByCpjiWg0ZHt08bO68j8vlkCuarMllF5MRaLR2ELU6kQkGxYJ+M2RdrGuAa+ORk1jobGnfYa5e/7usYaZOM@vger.kernel.org
X-Gm-Message-State: AFuF++k2hsT2+JNi7cO/zXaU5eq0Etmn7sK2BlPNmZ1Ycr3D5xa1/3yR
	S5cyuOlyNGRcl9raxoZ+ltNa04jc/kdAPVBTLxOlbWrDRZ0F/Na/LrOs30/qb97Uez8=
X-Gm-Gg: AYBFou3/iA+SxSJEL67+sf11dil4OtpLwZN0pq07etsnYqxT9ZidC4j+FsW8vb9UnXB
	Ggh5yQPbkVY+l1K4XDN0JYIFFqqn91AMO68fHkenzUlD2EFldxALf5QMZssoGP+wxxxx3lalRJx
	m4rx/+XBBSC5e0n9WBjOe2gatmdFFwPg2vHZ3pYRVnHivWO+LaoXrotjr+f4WQVJcf/kWP8HCi5
	xoYvzbbChYRTGqXGuR5OP+fyGvQqt3NqSmu3hS6GGUtyIffxMGS5aeH0wj/c8pqMNJxpjNrJHDo
	76kdzjaTfO/sk08Me5Exa7hz0xiZFNf2x4l8cRPxxZjoJ4CJ19ECLodFMb6VJxlhZ4TgnTLrQg/
	Qu6BACf9HorW6iV92QLKTOzLNUoxTwFU/f60xlWsM/WLHuvNSmgHLwNvJGZbK0Ylol7XLT6U0gj
	vguMBbiP3l3WuwSmUqXc3nal5MPtQqkcMMNuMN+IX3rt66XEIJQlvpGXOnnXFW1tEq2lU=
X-Received: by 2002:a05:600c:548c:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a027534bd7mr33259805e9.5.1790929942490;
        Fri, 02 Oct 2026 01:32:22 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03feed16bsm42507905e9.4.2026.10.02.01.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:32:22 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rudolf Marek <r.marek@assembler.cz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-watchdog@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] hwmon: Replace __MODULE_STRING() with __stringify()
Date: Fri,  2 Oct 2026 10:31:01 +0200
Message-ID: <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

__MODULE_STRING() has been an alias for __stringify() since "[PATCH]
MODULE_PARM support for older modules" [1] in 2002-12. That change also
moved it to the graveyard section at the end of linux/module.h

Replace the remaining uses of __MODULE_STRING() with __stringify() in
preparation for its removal.

Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/hwmon/fschmd.c         | 3 ++-
 drivers/hwmon/nct7904.c        | 5 +++--
 drivers/hwmon/sch56xx-common.c | 3 ++-
 drivers/hwmon/w83793.c         | 5 +++--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index 019fc32bf318..df9418a86c83 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -35,6 +35,7 @@
 #include <linux/miscdevice.h>
 #include <linux/uaccess.h>
 #include <linux/kref.h>
+#include <linux/stringify.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
@@ -43,7 +44,7 @@ static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 enum chips { fscpos, fscher, fscscy, fschrc, fschmd, fschds, fscsyl };
 
diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 976b8a008e44..04e1a8e6db37 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -23,6 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/watchdog.h>
+#include <linux/stringify.h>
 
 #define VENDOR_ID_REG		0x7A	/* Any bank */
 #define NUVOTON_ID		0x50
@@ -113,12 +114,12 @@
 static int timeout;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in minutes. 1 <= timeout <= 255, default="
-			__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+			__stringify(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+			__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static const unsigned short normal_i2c[] = {
 	0x2d, 0x2e, I2C_CLIENT_END
diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index a385aae3bb0f..febb8ba7dc2c 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -18,13 +18,14 @@
 #include <linux/watchdog.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <linux/stringify.h>
 #include "sch56xx-common.h"
 
 /* Insmod parameters */
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 #define SIO_SCH56XX_LD_EM	0x0C	/* Embedded uController Logical Dev */
 #define SIO_UNLOCK_KEY		0x55	/* Key to enable Super-I/O */
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index c6ef04c69856..e1f2708b5db6 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -34,6 +34,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/jiffies.h>
+#include <linux/stringify.h>
 
 /* Default values */
 #define WATCHDOG_TIMEOUT 2	/* 2 minute default timeout */
@@ -57,13 +58,13 @@ static int timeout = WATCHDOG_TIMEOUT;	/* default timeout in minutes */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in minutes. 2<= timeout <=255 (default="
-				__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+				__stringify(WATCHDOG_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  * Address 0x00, 0x0d, 0x0e, 0x0f in all three banks are reserved

-- 
2.55.0
