/*****************************************************************************
 *   Copyright (C) 2016 by Hikmet Bas                                        *
 *   <hikmet.bas@pardus.org.tr>                                              *
 *                                                                           *
 *   This program is free software; you can redistribute it and/or modify    *
 *   it under the terms of the GNU General Public License as published by    *
 *   the Free Software Foundation; either version 2 of the License, or       *
 *   (at your option) any later version.                                     *
 *                                                                           *
 *   This program is distributed in the hope that it will be useful,         *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 *   GNU General Public License for more details.                            *
 *                                                                           *
 *   You should have received a copy of the GNU General Public License       *
 *   along with this program; if not, write to the                           *
 *   Free Software Foundation, Inc.,                                         *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .          *
 *****************************************************************************/

#include "bridge.h"

Bridge::Bridge(QObject *parent) :
    QObject(parent),
    m_process(new QProcess(this))
{

}

QString Bridge::getHistory(const QString &program)
{
    m_process->start("bash", QStringList() << "-c" << program);
    m_process->waitForFinished(-1);
    QString bytes = m_process->readAllStandardOutput();
    return bytes;
}

QString Bridge::getUsers()
{
    m_process->start("bash", QStringList() << "-c" << "awk -F':' '{ if( $3>=1000 && $1 !=\"nobody\") print $1}' /etc/passwd");
    m_process->waitForFinished(-1);
    QByteArray bytes = m_process->readAllStandardOutput();
    QString out(bytes);
    return out;
}

Bridge::~Bridge()
{

}
