MIME-Version: 1.0
In-Reply-To: <1414428903-2381-1-git-send-email-teg@jklm.no>
References: <1414428903-2381-1-git-send-email-teg@jklm.no>
Date: Tue, 28 Oct 2014 00:31:17 -0200
Message-ID: <CAKi4VAKu27u=9=Fu_TUqRakrbWCUOPHMVoiimPJM3UfhgD0EyA@mail.gmail.com>
Subject: Re: [PATCH] static-nodes: indicate that creation of static nodes
 should only happen at boot
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Tom Gundersen <teg@jklm.no>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Oct 27, 2014 at 2:55 PM, Tom Gundersen <teg@jklm.no> wrote:
> udev will only manage static nodes that exist at the time udev is started, so
> creating static nodes later on will likely not behave as expected. In
> particular, recreating the static nodes at run-time will reset any permissions
> udev may have applied to the nodes at boot.
>
> See <https://bugzilla.redhat.com/show_bug.cgi?id=1147248> and the discussion
> following <http://permalink.gmane.org/gmane.comp.sysutils.systemd.devel/23795>.
>
> Note that this requires (the yet to be released) systemd v217 or a backport
> of systemd patch 8c94052ee543c3598a3c7b0c46688150aa2c6168.

Is this patch going to systemd-stable?

-- 
Lucas De Marchi
